class CartController < ApplicationController
  #rescue_form ActiveRecord::RecordNotFound, with: :invalid_cart
  before_action :set_cart
  before_action :authenticate_user!

  
  
  def index
    @carts = Cart.all
   # render json:
  end

  # def show
  #   @cart = Cart.find(params[:id])
  #   # Rest of the code to display the cart details...
  # rescue ActiveRecord::RecordNotFound
  #   redirect_to root_path, alert: "Cart not found."
  # end


  def show_cart_items
    @cart = current_user.cart
    if @cart.nil?
      render json: { message: "Cart not found for the user." }, status: :not_found
    else
      cart_items = @cart.cart_items.includes(:product)
      cart_items_data = cart_items.map do |cart_item|
        {
          id: cart_item.id,
          product_name: cart_item.product.name,
          product_name: cart_item.product.desc,
          product_price: cart_item.product.price
          # Add other product attributes you want to include in the response
        }
      end

      render json: { cart_items: cart_items_data }, status: :ok
    end
  end



  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)
    if @cart.save
     redirect_to @cart, alert: 'Cart was successfully created.' 
    else
      render :new 
    end
  end


  # def add_to_cart
  #   @product = Product.find(params[:product_id])
  #   @cart = current_user.cart
  #   @cart ||= Cart.create(user: current_user)
  #   @cart.cart_items.create(product: @product)
  #   redirect_to cart_path(@cart), notice: "Product successfully added to cart."
  # end
  
  def add_to_cart
    @product = Product.find(params[:product_id])
    @cart = current_user.cart
    @cart ||= Cart.create(user: current_user)
  
    if @cart.cart_items.create(product: @product)
      render json: { message: "Product successfully added to cart.", cart_id: @cart.id }, status: :ok
    else
      render json: { error: "Failed to add product to cart." }, status: :unprocessable_entity
    end
  end
  


  private

  def set_cart
    @cart = current_user.cart

    if @cart.nil?
      Rails.logger.error("Cart not found for the user.")
      @cart = Cart.create(user: current_user)
    end
  end


    def cart_params
      params.fetch(:cart, {})
    end

    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to root_path, notice: "That cart doesn't exist"
    end

end
