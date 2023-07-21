class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  #before_action :authenticate_user!, except: [:index, :show]

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

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
    end
  end

  private
    def set_product
      @product = Product.find_by(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404'
    end

    def product_params
      params.require(:product).permit(:name, :desc, :price)
    end
end
