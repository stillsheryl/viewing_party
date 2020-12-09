class DashboardController < ApplicationController
  before_action :require_user

  def index
    @friends = current_user.friends
  end

  def discover; end
end
