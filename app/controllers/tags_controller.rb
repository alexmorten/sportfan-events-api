class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]
  before_action :authenticate_user , only: [:create,:update,:destroy]

  # GET /tags
  def index
    @tags = Tag.all

    render json: @tags
  end

  # GET /tags/1
  def show
    render json: @tag
  end

  # POST /tags
  def create
    check_create_rights
    @tag = Tag.new(tag_params)

    if @tag.save
      render json: @tag, status: :created, location: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/1
  def update
    check_rights
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    check_rights
    @tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end
    def check_create_rights
      if @current_user.status == "normal"
        render json: {error: "you need to be verified"},status:401
      end
    end
    def check_rights
      if !(@tag.user == @current_user || @current_user.status == "admin")
        render json:{error:"not allowed"},status: 401
      end
    end
    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:user_id, :name)
    end
end
