module Stall
  class CartsController < Stall::ApplicationController
    before_action :check_if_cart_in_payment_state, only: :update
    before_action :load_cart, except: :show

    def show
      @cart = ProductList.find_by_token(params[:id]) || current_cart
    end

    def update
      respond_to do |format|
        service = Stall.config.service_for(:cart_update).new(@cart, cart_params)

        if service.call
          format.html.xhr do
            render 'show'
          end

          format.html.any do
            flash[:success] = t('stall.carts.flashes.update.success')
            redirect_to cart_path(@cart)
          end
        else
          format.html.xhr do
            render 'show'
          end

          format.html.any do
            flash[:error] = t('stall.carts.flashes.update.error')
            render 'show'
          end
        end
      end
    end

    private

    def load_cart
      @cart = ProductList.find_by_token!(params[:id])
    end

    def cart_params
      params.require(:cart).permit(
        line_items_attributes: [:id, :quantity, :_destroy]
      )
    end

    def check_if_cart_in_payment_state
      cart = ProductList.find_by_token!(params[:id])
      if cart && (cart.state == :payment)
        head :payment_required and return
      end
    end
  end
end
