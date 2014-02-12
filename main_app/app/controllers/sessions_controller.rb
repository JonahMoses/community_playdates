class SessionsController < ApplicationController

  def destroy
    if Rails.env.production?
      redirect_to "http://communityplaydates.com:3002/logout"
    else
      redirect_to "http://localhost:3002/logout"
    end
  end
end
