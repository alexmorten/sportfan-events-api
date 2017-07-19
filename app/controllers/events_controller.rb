class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create,:update,:destroy]
  # GET /events
  def index
    limit = params[:limit] && params[:limit].to_i <=1000 ? params[:limit] : 20
    lat = params[:lat]
    lng = params[:lng]
    dist = params[:dist]
    query = params[:query] ? params[:query] : ""
    if @group_events
      @events = @group_events
    else
      @events = Event.all
    end

    render json: @events,lat:lat,lng:lng
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    check_create_rights
    @event = Event.new(event_params)
    @event.user = @current_user
    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    check_access_rights
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    check_access_rights
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:title, :description, :lat, :lng, :date,:group_id)
    end
    def check_create_rights
      if @current_user.status == "normal"
        render json: {error: "you need to be verified"},status:401
      end
    end
    def check_access_rights
      if !(@event.user == @current_user || @current_user.status == "admin")
        render json: { error:"not allowed" }, status: 401
      end
    end
end
