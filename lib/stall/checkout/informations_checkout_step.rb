module Stall
  module Checkout
    class InformationsCheckoutStep < Stall::Checkout::Step
      validations do
        validate :customer_accepts_terms
        validates :customer, :shipping_address, presence: true

        validates :billing_address, presence: true,
          if: :use_another_address_for_billing?

        nested :shipping_address do
          validates :civility, :first_name, :last_name, :address, :country,
                    :zip, :city, presence: true
        end

        nested :billing_address do
          validates :civility, :first_name, :last_name, :address, :country,
                    :zip, :city, presence: true
        end
      end

      def prepare
        ensure_customer
        prefill_addresses_from_customer
        ensure_shipment
        ensure_payment
      end

      def process
        prepare_user_attributes
        prepare_addresses_attributes
        cart.assign_attributes(cart_params)

        unless valid?
          Rails.logger.debug("[Stall::Checkout::InformationsCheckoutStep] cart (#{cart.inspect}) errors: #{cart.errors.full_messages.join}")

          return false
        end

        cart.save.tap do |valid|
          assign_addresses_to_customer!
          calculate_shipping_fee!
        end
      end

      private

      # To easily add permitted parameters, use the following method in your
      # subclass :
      #
      #   def cart_params
      #     super(customer_attributes: [nested: :attribute])
      #   end
      #
      # Note : If you want to remove permitted parameters, you need to rewrite
      # the full permissions nested array
      #
      def cart_params(*attributes)
        @cart_params ||= super(
          *merge_arrays(
            [
              :use_another_address_for_billing, :terms,
              :payment_method_id, :shipping_method_id,
              customer_attributes: [
                :id, :email, user_attributes: [
                  :password, :password_confirmation
                ]
              ],
              shipping_address_attributes: [
                :id, :civility, :first_name, :last_name, :address,
                :address_details, :country, :zip, :city, :phone, :state
              ],
              billing_address_attributes: [
                :id, :civility, :first_name, :last_name, :address,
                :address_details, :country, :zip, :city, :phone, :state,
                :_destroy
              ],
              shipment_attributes: [
                :id, :shipping_method_id
              ],
              payment_attributes: [
                :id, :payment_method_id
              ]
            ],
            attributes
          )
        )
      end

      def ensure_customer
        cart.build_customer unless cart.customer
      end

      def ensure_shipment
        cart.build_shipment unless cart.shipment
      end

      def ensure_payment
        cart.build_payment unless cart.payment
      end

      # Remvove user attributes when no account should be created, for an
      # "anonymous" order creation.
      #
      def prepare_user_attributes
        return if params[:create_account] == '1'

        if cart_params[:customer_attributes] && cart_params[:customer_attributes][:user_attributes]
          cart_params[:customer_attributes].delete(:user_attributes)
        end

        # Remove user from customer to avoid automatic validation of the user
        # if no user should be saved with the customer
        unless user_signed_in? || cart.customer.try(:user).try(:persisted?) ||
          !cart.customer
        then
          cart.customer.user = nil
        end
      end

      # If the billing address should be set to the same as the filled shipping
      # address, we remove the billing address parameters
      #
      def prepare_addresses_attributes
        unless use_another_address_for_billing?
          cart_params.delete(:billing_address_attributes)
          cart.billing_address.try(:mark_for_destruction) if cart.billing_address?
        end
      end

      # Assigns the shipping fees to the cart based on the selected shipping
      # method
      #
      def calculate_shipping_fee!
        service_class = Stall.config.service_for(:shipping_fee_calculator)
        service_class.new(cart).call
      end

      # Fetches addresses from the customer account and copy them to the
      # cart to pre-fill the fields for the user
      #
      def prefill_addresses_from_customer
        # Do not fill addresses if we have errors on the address models since 
        # it means the form has just been submitted
        return if cart.shipping_address && cart.shipping_address.errors.any?

        Stall::Addresses::PrefillTargetFromSource.new(cart.customer, cart).copy
      end

      # Copies the addresses filled in the cart to the customer account for
      # next orders informations pre-filling
      #
      def assign_addresses_to_customer!
        Stall::Addresses::CopySourceToTarget.new(cart, cart.customer).copy!
      end

      def use_another_address_for_billing?
        @use_another_address_for_billing ||= cart_params[:use_another_address_for_billing] == '1'
      end

      def customer_accepts_terms
        cart.errors.add(:terms, :accepted) unless cart.terms == '1'
      end
    end
  end
end
