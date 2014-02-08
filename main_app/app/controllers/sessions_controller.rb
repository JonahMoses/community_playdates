class SessionsController < ApplicationController

  def destroy
    redirect_to "http://localhost:3002/logout"
  end
end
