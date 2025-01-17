module Stall
  class CreditUsageService < Stall::BaseService
    class CartAlreadyPaidError < StandardError; end

    attr_reader :cart, :params

    def initialize(cart, params = {})
      @cart = cart
      @params = params
    end

    def call
      ensure_cart_paid!('Cannot udpate credit note from paid cart')

      return false unless enough_credit?

      clean_credit_note_adjustments!

      available_credit_notes.reduce(amount) do |missing_amount, credit_note|
        break true if missing_amount.to_d == 0

        used_amount = [credit_note.remaining_amount, missing_amount].min
        add_adjustment(used_amount, credit_note)

        missing_amount - used_amount
      end
    end

    def amount
      @amount ||= begin
        amount = if params[:amount]
          cents = BigDecimal(params[:amount]) * 100
          Money.new(cents, cart.currency)
        else
          credit
        end

        [amount, cart.total_price].min
      end
    end

    def credit
      @credit ||= begin
        credit = cart.customer.try(:credit, cart.currency) || Money.new(0, cart.currency)
        Money.new(credit + credit_note_adjustments.map(&:price).sum.abs, cart.currency)
      end
    end

    def enough_credit?
      amount <= credit
    end

    def clean_credit_note_adjustments!
      ensure_cart_paid!('Cannot remove credit note from paid cart')

      credit_note_adjustments.each do |adjustment|
        cart.adjustments.destroy(adjustment)
      end
    end

    # FIXME: Ducktyping ShippingFeeCalculatorService and use this method in
    # CartUpdateService#refresh_associated_services! to test if credit notes exists
    #
    def available?
      cart.respond_to?(:adjustments)
    end

    def credit_used?
      credit_note_adjustments.any?
    end

    def credit_used
      credit_note_adjustments.map(&:price).sum
    end

    def ensure_valid_or_remove!
      if !enough_credit?
        clean_credit_note_adjustments!
      elsif cart.total_price.to_d < 0
        @amount = credit_used
        call
      end
    end

    private

    def available_credit_notes
      @available_credit_notes ||= cart.customer.credit_notes
        .for_currency(cart.currency)
        .select(&:with_remaining_money?)
    end

    def add_adjustment(amount, credit_note)
      cart.adjustments.create!(
        type: 'CreditNoteAdjustment',
        name: I18n.t('stall.credit_notes.adjustment_label', ref: credit_note.reference),
        price: -amount,
        credit_note: credit_note
      )
    end

    def credit_note_adjustments
      @credit_note_adjustments ||= cart.adjustments.select do |adjustment|
        CreditNoteAdjustment === adjustment
      end
    end

    def ensure_cart_paid!(error_message)
      raise(CartAlreadyPaidError, error_message) if cart.paid?
    end
  end
end
