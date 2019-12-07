class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /productos
  def giveMeProducts
    #    if params[:token].present? && params[:token] == session[:token] && params[:q].present?
        @products = Product.all
        if params[:q].present?
          query = {}
          if params[:q] == 'scarce'
              query = Product.getScarce(@products)
          elsif params[:q] == 'all'
              query = Product.getAll(@products)
          end
        else 
          query = Product.getInStock(@products)
        end
        render json: query.first(25)
    end

  def codProd
    result = Product.prodWithCod(params[:codigo])
    if result.blank?
      render status: 404
    else
      render json: result
    end
  end

  def prodWithCodeInItems
    result = Product.prodCodeItems(params[:codigo])
    if result.blank?
      render status: 404
    else
      render json: result
    end
  end

  def prodWithItems
    if params[:number].present?
      prodItem = params[:numbre]
      product = Product.prodWithCod(params[:codigo]) 
      prodItem.to_i.times {Item.create_for(product)}
    else
      render status: 404
    end
  end

  # GET /products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.permit(:unicode, :descrip, :detail, :price, :name)
      #sacar los requiere
    end
end
