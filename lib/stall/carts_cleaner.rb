module Stall
  class CartsCleaner
    attr_reader :cart_model

    def initialize(cart_model)
      @cart_model = cart_model
    end

    def clean!
      clean_empty_carts
      clean_aborted_carts
    end

    private

    # Empty carts are cleaned with a .delete_all call for optimization.
    #
    # Empty carts should not need to run destroy callbacks, not being related to
    # any external model.
    #
    def clean_empty_carts
      carts = cart_model.empty.older_than(Stall.config.empty_carts_expires_after.ago)
      carts = carts.without_payment if cart_model == Cart

      log "Cleaning #{carts.count} empty carts ..."
      carts.destroy_all
      log 'Done.'
    end

    # Unpaid carts have line items and other models related. Since empty carts
    # are already cleaned, there should not be too many carts to destroy here
    # and we can safely use .destroy_all to deeply clean carts.
    #
    # Note : The given cart model should implement the `.unpaid` method
    def clean_aborted_carts
      carts = cart_model.aborted
      carts = carts.reject { |cart| cart.payment.present? || cart.shipment.present? } if cart_model == Cart

      log "Cleaning #{carts.count} aborted carts ..."
      carts.each(&:destroy)
      log 'Done.'
    end

    def log(*args)
      puts(*args) unless Rails.env.test?
    end
  end
end
