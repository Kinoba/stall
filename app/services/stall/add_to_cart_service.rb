# frozen_string_literal: true

module Stall
  # AddToCartService
  class AddToCartService < Stall::AddToProductListService
    alias cart product_list

    def call
      line_items_array = @service_params[:line_items] || [@service_params[:line_item]]

      line_items_array.each do |line_item_object|
        @each_line_item = line_item_object

        unless line_item_valid?
          return false if @service_params[:line_item].present?

          next
        end

        cart.line_items << line_item unless assemble_identical_line_items
      end

      cart.save.tap do |saved|
        Rails.logger.debug("[App::Stall::AddToCartService] cart errors: #{cart.errors}")
        return false unless saved

        # Recalculate shipping fee if available for calculation to ensure
        # that the fee us always up to date when displayed to the customer
        shipping_fee_service.call if shipping_fee_service.available?
      end
    end

    def line_item_valid?
      line_item.valid? && enough_stock?
    end

    def enough_stock?
      stock_service = Stall.config.service_for(:available_stocks).new
      stock_service.on_hand?(line_item)
    end

    private

    def shipping_fee_service
      @shipping_fee_service ||= Stall.config.service_for(:shipping_fee_calculator).new(cart)
    end
  end
end
