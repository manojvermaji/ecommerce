# module CurrentCart

#   private

#   def set_cart
#     @cart = Cart.find(session[:cart_id])
#   rescue ActiveRecord::RecordNotFound
#     @cart = Cart.create
#     session[:cart_id] = @cart.id
#   end
# end

module CurrentCart
  extend ActiveSupport::Concern

  private

  def set_cart
    begin
      @cart = Cart.find(params[:cart_id] || session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
    end

    session[:card_id] = @cart.id
  end
end
