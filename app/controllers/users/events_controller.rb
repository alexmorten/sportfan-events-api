class Users::EventsController < EventsController
  before_action :set_group_events
    private
        def set_group_events
            @group_events = User.find(params[:user_id]).events
        end
end
