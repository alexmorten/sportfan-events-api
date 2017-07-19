class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only:[:create,:update,:destroy]
  # GET /groups
  def index
    if @groupable
      @groups = @groupable.groups
    else
      @groups = Group.all
    end
    render json: @groups
  end

  # GET /groups/1
  def show
    render json: @group
  end

  # POST /groups
  def create
    check_create_rights
    @group = @groupable.groups.new(group_params)
    @group.user = @current_user
    if @group.save
      render json: @group, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  def update
    check_access_rights
    if @group.update(group_params)
      render json: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  def destroy
    check_access_rights
    @group.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_params
      params.require(:group).permit(:name, :description)
    end
    def check_create_rights
      if @current_user.status == "normal"
        render json: {error: "you need to be verified"},status:401
      end
    end
    def check_access_rights
      if !(@group.user == @current_user || @current_user.status == "admin")
        render json: { error:"not allowed" }, status: 401
      end
    end
end
