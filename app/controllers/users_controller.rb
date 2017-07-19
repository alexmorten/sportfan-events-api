class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]
  before_action :authenticate_user!, only: :update
  # GET /users
  def index
    @users = User.where(status:"verified")

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # PATCH/PUT /users/1
  def update
    check_rights
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

    def check_rights
      if !(@current_user == @user || @current_user.status == admin)
        render json: {error:"not allowed"},status:401
        return
      end
      p = user_params
      if p.status && @current_user.status !="admin"
        render json: {error:"not allowed"},status:401
        return
      end
    end
    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name,website,:description,:lat,:lng,:status)
    end
end
