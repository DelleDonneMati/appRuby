class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def login
    @user = User.find_by(username: params[:u], password: params[:p])  
    if @user.present?
      expiration = Time.now.utc + 30.minutes
      authentication =  Digest::SHA1.hexdigest "#{@user.id}#{@user[:passwd]}#{@user[:username]}#{expiration}"
      token = Token.new(user_id: @user[:id], authentication: authentication, created_at: Time.now.utc, updated_at: Time.now.utc)
      token.save
      render json: token
    end
  end



  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:username, :password)
    end
end
