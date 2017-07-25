class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create,:update,:destroy]
  # GET /events
  def index
    limit = params[:limit] && params[:limit].to_i <=1000 ? params[:limit] : 20
    lat = params[:lat]
    lng = params[:lng]
    include_past_events = params[:include_past] || false
    exclude_future_events = params[:exclude_future] || false
    startDate = params[:startDate] || nil
    endDate = params[:endDate] || nil
    dist = params[:dist]
    query = params[:query] || ""
    if @group_events
      @events = @group_events
    else
      @events = Event.all
    end

    @events = @events.where("LOWER(title) LIKE LOWER(?) OR LOWER(description) LIKE LOWER(?)","%#{query}%","%#{query}%")

    # if !include_past_events
    #  @events = @events.where("date > ?",Time.now)
    # end
    if startDate && endDate
      @events = @events.where("date > ? AND date < ? ",Time.at(startDate.to_i),Time.at(endDate.to_i))
    elsif exclude_future_events
      @events = @events.where("date < ?",Time.now)
    elsif !include_past_events
      @events = @events.where("date > ?",Time.now)
    end

    if lat && lng && dist
      @events = @events.within(dist, :origin => [lat,lng])
                   .order(date: :asc)
                   .limit(limit)
    elsif lat && lng
      @events = @events.by_distance(:origin => [lat,lng])
                   .limit(limit)
    else
      @events = @events.order(date: :asc)
                   .limit(limit)
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
