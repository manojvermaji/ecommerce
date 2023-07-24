class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_url(@product), alert: "Product was successfully created." 
    else
      render :new 
    end
    
  end

  def update
     if @product.update(product_params)
      redirect_to product_url(@product), alert: "Product was successfully updated." 
      else
        render :edit
      end
  end

  def destroy
    @product.destroy
      redirect_to products_url, alert: "Product was successfully destroyed." 
  end

  private
    def set_product
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404'
    end

    def product_params
      params.require(:product).permit(:name, :desc, :price)
    end
end
