module Stall
  module Checkout
    class StepsController < Stall::CheckoutBaseController
      skip_before_action :verify_authenticity_token, on: :foreign_update
      before_action :load_cart
      before_action :load_step
      before_action :ensure_cart_checkoutable

      def show
        @step.prepare
      end

      def update
        Rails.logger.debug("[Stall::Checkout::StepsController] @step (#{@step.inspect})")
        if @step.process
          @wizard.validate_current_step!
          redirect_to step_path
        else
          @step.prepare
          flash[:error] ||= t("stall.checkout.#{@wizard.current_step_name}.error")
          render 'show'
        end
      end

      alias_method :foreign_update, :update

      def change
        target_step = params[:step]

        if @wizard.step_complete?(target_step)
          @wizard.move_to_step!(target_step)
          redirect_to step_path
        else
          @step.prepare
          flash[:error] ||= t("stall.checkout.#{target_step}.error")
          render 'show'
        end
      end

      private

      def load_cart
        @cart = current_cart

        # If the cart is not checkoutable, look for a potential cart could have
        # just been paid and that would be archived it a specific cookie, or
        # exit from the checkout
        unless @cart.checkoutable?
          if archived_paid_cart?
            @cart = archived_paid_cart
          else
            redirect_from_uncheckoutable_cart!
          end
        end
      end

      def find_cart(identifier, ensure_active_cart = true)
        super(identifier, false)
      end

      def load_step
        @wizard = @cart.wizard.new(@cart)

        @step = @wizard.initialize_current_step do |step|
          # Inject request dependent data
          step.inject(:params, params)
          step.inject(:session, session)
          step.inject(:cookies, cookies)
          step.inject(:request, request)
          step.inject(:flash, flash)
          step.inject(:user_signed_in?, user_signed_in?)
          step.inject(:current_user, current_user)

          if Stall.config.steps_initialization
            instance_exec(step, &Stall.config.steps_initialization)
          end
        end
      end

      def ensure_cart_checkoutable
        unless @cart.active? || @step.allow_inactive_carts?
          remove_cart_from_cookies(@cart.identifier)
          @cart = @cart.class.new
        end

        redirect_from_uncheckoutable_cart! unless @cart.checkoutable?
      end

      def redirect_from_uncheckoutable_cart!
        flash[:error] = t('stall.checkout.shared.not_checkoutable')
        redirect_to_referrer_or_root
      end

      def redirect_to_referrer_or_root
        referrer = URI.parse(request.referrer).path if request.referrer

        redirect_target = if referrer && referrer != request.path
          request.referrer
        else
          root_path
        end

        redirect_to redirect_target
      end
    end
  end
end
