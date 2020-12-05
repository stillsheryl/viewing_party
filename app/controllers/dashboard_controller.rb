class DashboardController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def discover; end
end
