# frozen_string_literal: true

module Stall
  # AddToProductListService
  class AddToProductListService < Stall::BaseService
    attr_reader :product_list, :service_params

    def initialize(product_list, service_params)
      super()
      @product_list = product_list
      @service_params = service_params
    end

    def call
      raise NotImplementedError,
            'Override #call in Stall::AddToProductListService subclasses'
    end

    def line_item
      @line_item = sellable.to_line_item.tap do |line_item|
        line_item.product_list = product_list
        line_item.quantity = quantity
      end
    end

    def line_item_params?
      line_item_params.any?
    end

    private

    def assemble_identical_line_items
      # Find an existing line item which is like our new one
      existing_line_item = product_list.line_items.find do |li|
        line_item.like?(li)
      end

      # If we found one, we assemble both line items into the old one, to avoid
      # duplicating the same sellables in the product list
      if existing_line_item
        existing_line_item.quantity += line_item.quantity
        @line_item = existing_line_item
      else
        false
      end
    end

    def sellable
      @sellable = sellable_class.find(line_item_params[:sellable_id])
    end

    def sellable_class
      @sellable_class = line_item_params[:sellable_type].camelize.constantize
    end

    def quantity
      @quantity = line_item_params[:quantity]
    end

    def line_item_params
      @line_item_params = if @service_params[:line_item].present?
                            @service_params.require(:line_item).permit(:sellable_type, :sellable_id, :quantity)
                          elsif @service_params[:line_items].present?
                            @each_line_item.permit(:sellable_type, :sellable_id, :quantity)
                          end
    rescue ActionController::ParameterMissing
      {}
    end
  end
end
