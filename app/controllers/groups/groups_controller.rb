class Groups::GroupsController < GroupsController
    before_action :set_groupable

    private
        def set_groupable
            @groupable = Group.find(params[:group_id])
        end
end
