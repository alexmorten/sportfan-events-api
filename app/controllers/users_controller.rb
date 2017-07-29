class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]
  before_action :authenticate_user!, only: :update
  # GET /users
  def index
    limit = params[:limit] && params[:limit].to_i <=1000 ? params[:limit] : 20
    query = params[:query] || ""
    status = "verified"
    if user_signed_in? && current_user.status == "admin" && params[:status]
      status = params[:status]
    end
    @users = User.where(status:status).limit(limit).where('LOWER(name) LIKE LOWER(?)',"%#{query}%")

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # PATCH/PUT /users/1
  def update
    if rights_violated
      return
    end
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def rights_violated
      if !(@current_user == @user || @current_user.status == "admin")
        render json: {error:"not allowed"},status:401
        return true
      end

      if user_params[:status] && @current_user.status !="admin"
        render json: {error:"not allowed"},status:401
        return true
      end
    end
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name,:website,:description,:lat,:lng,:status)
    end
end
