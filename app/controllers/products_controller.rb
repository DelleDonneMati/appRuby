class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :validate_product, only: [:find_produts_in_items_with_unicode, :find_by_unicode]
  # get '/productos'   

  def index
    if params[:q].present?
      query = {}
      if params[:q] == 'scarce'
          query = Product.get_scarce
      elsif params[:q] == 'all'
          query = Product.get_all
      end
    else 
      query = Product.get_in_stock
    end
    render json: query.first(25)
  end

  # get '/productos/:codigo'

  def find_by_unicode
    render json: @product
  end

  # get '/productos/:codigo/items'

  def find_produts_in_items_with_unicode
    items = Item.where(product_id: @product.id)
    render json: items
  end

  # post '/productos/:codigo/items

  def new_items_with_products
    if params[:cant].present?
      create = params[:cant]
      product = Product.find_by(unicode: params[:codigo]) 
      Product.createItems(product.id, create)   
    else
      render json: {status: 406}
    end
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

    def validate_product
      @product = Product.find_by(unicode: params[:codigo])
      if @product.blank?
       render json: 'status: 404' 
      end
    end
end
