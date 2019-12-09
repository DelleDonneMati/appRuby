class SellsController < ApplicationController
  before_action :set_sell, only: [:show, :update, :destroy]

  # get '/ventas'
  def user_sales
    if params[:authentication].present?
      token = params[:authentication]
      user = Token.authenticate(token)
      if user.present?
        sales = Sell.where(user_id: user.id).select(:created_at, :total, :client_id)
        sales = sales.map { |sale| {"Client": "#{Client.find(sale.client_id).name}", "Date": "#{sale.created_at}", "Total": "#{sale.total}"}} 
        render json: sales
      else
        render status: 404
      end
    end
  end 

  def sellUser
    if params[:authentication].present?
      token = params[:authentication]
      user = Token.authenticate(token)
      if user.present?
        sales = Sell.find(params[:id])
        sales = {"Client": "#{Client.find(sales.client_id).name}", "Date": "#{sales.created_at}", "Total": "#{sales.total}"}
        if params[:items].present?
          sales[:Items] = Sold.joins(:sell, :item).where("solds.sell_id= 1").select("items.*")
        end
        render json: sales
      else
        render status: 404
      end
    end
  end

  def newSell
    if params[:authentication].present?
      token = params[:authentication]
      user = Token.authenticate(token)
      if user.present?
        Sell.sell(params, user)
      else
        render status: 404
      end
    else
      render status: 404
    end
  end


  # GET /sells
  def index
    @sells = Sell.all

    render json: @sells
  end

  # GET /sells/1
  def show
    render json: @sell
  end

  # POST /sells
  def create
    @sell = Sell.new(sell_params)

    if @sell.save
      render json: @sell, status: :created, location: @sell
    else
      render json: @sell.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sells/1
  def update
    if @sell.update(sell_params)
      render json: @sell
    else
      render json: @sell.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sells/1
  def destroy
    @sell.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sell
      @sell = Sell.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sell_params
      params.permit(:client_id, :user_id, :reservation_id)
    end
 end