class CartItemController < ApplicationController
  include CurrentCart
  before_action :set_cart_item, only: [:show, :destroy]


  def index
    @cart_item = CartItem.all
  end

  def show
  end

  def new 
    @cartitem = CartItem.new
  end

  def create
    product = Product.find(params[:product_id])
    @cartitem = @cart.add_product(cart_item_params)#product

    if @cartitem.save
      format.html { redirect_to @cart_item.cart, notice: 'Item added to cart' }
    else
      format.html { render :new }
    end
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    @cartitem.destroy 
    format.html { redirect_to cart_path(@cart), notice: 'Item successfully removed.' }
  end

  private
  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_id)
  end


end
