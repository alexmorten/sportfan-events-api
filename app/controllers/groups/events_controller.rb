class Groups::EventsController < EventsController
  before_action :set_group_events
    def index
      @events = @group.events

      render json: @events
    end

    private
        def set_group_events
            @group_events= Group.find(params[:group_id]).sub_events
        end
end
