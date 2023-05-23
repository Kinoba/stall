# frozen_string_literal: true

module Stall
  # LineItemsController
  class LineItemsController < Stall::ApplicationController
    def create
      status = service.call

      @quantity = params[:line_item][:quantity].to_i if status.present? && params[:line_item].present?
      @line_item = service.line_item if params[:line_item].present?

      # Allow subclasses to hook into successful | failed product list add
      yield(status) if block_given?
      # We do not render if the yield block already has done it
      render partial: status.present? ? 'added' : 'add_error' if response_body.blank?
    end

    private

    def product_list
      raise NotImplementedError, 'Override #product_list in subclass'
    end

    def service
      raise NotImplementedError, 'Override #service in subclass'
    end
  end
end
