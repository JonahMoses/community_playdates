class LandingController < ApplicationController
  def index
    if cookies.signed[:user_id]
      if Rails.env.development?
        redirect_to "http://localhost:3000"
      else
        redirect_to "http://communityplaydates.com"
      end
    end
  end
end
