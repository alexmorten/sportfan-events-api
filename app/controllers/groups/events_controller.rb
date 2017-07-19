class Groups::EventsController < EventsController
  before_action :set_group_events
  

    private
        def set_group_events
            @group_events= Group.find(params[:group_id]).sub_events
        end
end
