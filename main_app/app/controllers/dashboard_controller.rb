class DashboardController < ApplicationController

  def index
    if current_user
      user_data = current_user.get_all_friend_data
      # @friends = user_data["friends"].take(3)
      # @friends_of_friends = user_data["friends"].take(3)

      @friends = [current_user, current_user, current_user]
      @friends_of_friends = [current_user, current_user, current_user]

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
