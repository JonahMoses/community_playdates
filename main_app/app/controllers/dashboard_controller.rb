class DashboardController < ApplicationController

  def index
    if current_user
      @friends = current_user.friends

      friends_of_friends = current_user.friends.map(&:friends).flatten
      @friends_of_friends = current_user.friends_of_friends
      @general_public = []
    else
      if Rails.env.production?
        redirect_to "http://communityplaydates.com/:3002"
      else
        redirect_to "http://localhost:3002"
      end
    end

  end

end
