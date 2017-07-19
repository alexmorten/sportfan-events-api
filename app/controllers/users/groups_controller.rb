class Users::GroupsController < GroupsController
    before_action :set_groupable
    def index
      @groups = @groupable.groups

      render json: @groups
    end
    private
        def set_groupable
            @groupable = User.find(params[:user_id])
        end
end
