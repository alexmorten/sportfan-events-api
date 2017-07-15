class Users::GroupsController < GroupsController
    before_action :set_groupable

    private
        def set_groupable
            @groupable = User.find(params[:user_id])
        end
end
