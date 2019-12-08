class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]

  # get '/reservas'

  def reservNotSold
    query = Reservation.joins(:client).where(status: 'Pendiente').select(:"reservations.created_at", :name, :total)
    render json: query
  end

  #get '/reservas/:id'
  def reservId
    res = {}
    res['Reserva'] = Reservation.findById(params[:id])
    if res['Reserva'].blank?
      res['Items'] = Reserved.giveMeItems(params[:id]) if params[:items].present?       
      res['Venta'] = Sell.giveMeSale(params[:id]) if params[:sale].present?
      render json: res
    else 
      render status: 404
    end
  end

  # GET /reservations
  def index
    @reservations = Reservation.all

    render json: @reservations
  end

  # GET /reservations/1
  def show
    render json: @reservation
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: @reservation, status: :created, location: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/1
  def destroy
    @reservation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reservation_params
      params.permit(:client_id, :user_id, :date, :status, :total)
    end
end
