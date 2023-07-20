class CartController < ApplicationController
  #rescue_form ActiveRecord::RecordNotFound, with: :invalid_cart
  before_action :set_cart, only: [:show, :destroy]

  
  
  def index
    @carts = Cart.all
  end

  def show
    @cart = Cart.find(params[:id])
    # Rest of the code to display the cart details...
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Cart not found."
  end


  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
    else
      format.html { render :new }
    end
  end


  def add_to_cart
    @product = Product.find(params[:product_id])
    @cart = current_user.cart
    @cart ||= Cart.create(user: current_user)
    @cart.cart_items.create(product: @product)
    redirect_to cart_path(@cart), notice: "Product successfully added to cart."
  end
  

  def destroy
    @cart.destroy 
    if @cart.id == session[:cart_id]
    session[:cart_id] = nil
      format.html { redirect_to root_path, notice: 'Cart was successfully destroyed.' }
    end
  end

  private
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params.fetch(:cart, {})
    end

    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to root_path, notice: "That cart doesn't exist"
    end

end
