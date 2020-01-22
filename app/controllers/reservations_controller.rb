class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]
  before_action :validate_user, only: [:index, :find_by_id, :to_sell, :create_reservation]
  # get '/reservas'

  def index    
    # query = Reservation.notSold
    query = Reservation.joins(:client).where(status: 'Disponible').select(:"reservations.id", :created_at, :name, :total)
    render json: query
  end

  # get '/reservas/:id'
  def find_by_id
    res = {}
    res['Reserva'] = Reservation.findById(params[:id])
    if res['Reserva'].present?
      res['Items'] = Reserved.giveMeItems(params[:id]) if params[:items].present?       
      res['Venta'] = Sell.giveMeSale(params[:id]) if params[:sale].present?
      render json: res
    else 
      render json: 'status: 404'
      #render :json => {:error => "404 Not-Found"}.to_json, :status => 404
    end
  end

  # post '/reservas'
  def create_reservation     
    if params[:client_id].present? && params[:to_reserve].present?
      response = Reservation.reserve(params, @user)
      render json: response
    else 
      render json: {message: 'Missing parameters', status: 406 }
    end
  end

  # delete '/reservas/:id'
  def deleteId
    reserv = Reservation.find(params[:id])
    if reserv.present? && (reserv.status != 'Vendido')
      available = Reserved.where(reservation_id: res.id)
      available.map { |free| Item.find(free.item_id).update!(status: 'Disponible') }
      Reservation.delete(params[:id]) 
    end
  end

  #PUT /reservas/:id/vender
  
  def to_sell
    reserv = Reservation.find(params[:id])
    if reserv.present?
      if reserv.status = 'Pendiente'
        sale = Reservation.sell(res, @user)
        result = sale
      else
        result =  {message: 'Ya se ha vendido esta Reserva', status: 406 }  
      end
    else
      result = {message: 'No se encontro la Reserva', status: 404 }
    end
   render json: result 
  end

  # GET /reservations
  # def index
  #   @reservations = Reservation.all

  #   render json: @reservations
  # end

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

    def validate_user
      @user = Token.authenticate(params[:authentication])
      if @user.blank?
        render json: {status: 404}
      end
    end
end
