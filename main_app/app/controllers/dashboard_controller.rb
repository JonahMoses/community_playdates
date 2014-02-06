class DashboardController < ApplicationController

  def index
    if current_user
    else
      redirect_to "http://localhost:3002"
    end

  end

end
