class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]

  # get '/reservas'

  def reservNotSold
    user = Token.authenticate(params[:authentication])
    if user.present?    
      #query = Reservation.NotSold
      query = Reservation.joins(:client).where(status: 'Pendiente').select(:"reservations.id", :created_at, :name, :total)
      render json: query
    else
      render status: 404
    end
  end

  # get '/reservas/:id'
  def reservId
    res = {}
    res['Reserva'] = Reservation.findById(params[:id])
    if res['Reserva'].present?
      res['Items'] = Reserved.giveMeItems(params[:id]) if params[:items].present?       
      res['Venta'] = Sell.giveMeSale(params[:id]) if params[:sale].present?
      render json: res
    else 
      render status: 404
      #render :json => {:error => "404 Not-Found"}.to_json, :status => 404
    end
  end

  # post '/reservas'
  def createReservation
    user = Token.authenticate(params[:authentication])
    if user.present?  
      if params[:client_id].present? && params[:to_reserve].present?
        response = Reservation.reserve(params, user)
        render json: response
      else 
        render json: {message: 'Missing parameters', status: 406 }
      end
    else
      render status: 404
    end
  end

  # delete '/reservas/:id'
  def deleteId
    user = Token.authenticate(params[:authentication])
    if user.present?    
      reserv = Reservation.find(params[:id])
      if reserv.present? && (reserv.status != 'Vendido')
        available = Reserved.where(reservation_id: res.id)
        available.map { |free| Item.find(free.item_id).update!(status: 'Disponible') }
        Reservation.delete(params[:id]) 
      end
    else 
      render status: 404
    end
  end

  #PUT /reservas/:id/vender
  
  def toSell
    user = Token.authenticate(params[:authentication])
    if user.present? 
      reserv = Reservation.find(params[:id])
      if reserv.present?
        if reserv.status = 'Pendiente'
          sale = Reservation.sell(res, user)
          result = sale
        else
          result =  {message: 'Ya se ha vendido esta Reserva', status: 406 }  
        end
      else
        result = {message: 'No se encontro la Reserva', status: 404 }
      end
      render json: result
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
