class MiscController < ApplicationController
before_action :authenticate_user!, only: :me
def me
  render json: @current_user
end

end
