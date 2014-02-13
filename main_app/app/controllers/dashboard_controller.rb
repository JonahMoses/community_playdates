class DashboardController < ApplicationController

  def index
    if current_user
      # user = current_user.get_all_friend_data
      @friends = current_user.friends.take(3)
      @friends_of_friends = current_user.friends_of_friends.take(3)

      @general_public = []
    else
      if Rails.env.production?
        redirect_to "http://communityplaydates.com/welcome"
      else
        redirect_to "http://localhost:3002"
      end
    end

  end

end
