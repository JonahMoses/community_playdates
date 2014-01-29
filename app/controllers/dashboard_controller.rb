class DashboardController < ApplicationController

  def index
    if current_user
    else
      redirect_to welcome_path
    end
  end

end
