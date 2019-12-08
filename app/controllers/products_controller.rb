class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # get '/productos'

  def giveMeProducts
    if params[:q].present?
      query = {}
      if params[:q] == 'scarce'
          query = Product.getScarce
      elsif params[:q] == 'all'
          query = Product.getAll
      end
    else 
      query = Product.getInStock
    end
    render json: query.first(25)
  end

  # get '/productos/:codigo'

  def codProd
    product = Product.find_by(unicode: params[:codigo])
    if product.blank?
      render status: 404 
    else
      render json: product
    end
  end

  # get '/productos/:codigo/items'

  def prodWithCodeInItems
    product = Product.find_by(unicode: params[:codigo]) 
    if product.blank?
      render status: 404 
    else
      items = Item.where(product_id: product.id)
      render json: items
    end
  end

  # post '/productos/:codigo/items

  def createItemsWithProd
    if params[:cant].present?
      create = params[:cant]
      product = Product.find_by(unicode: params[:codigo]) 
      Product.createItems(product.id, create)   
    else
      render status: 406
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
    end
end
