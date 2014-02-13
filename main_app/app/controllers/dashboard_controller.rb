class DashboardController < ApplicationController

  def index
    if current_user
      user = UserClient.get_all_friend_data(current_user.id)
      @friends = user.friends.take(3)
      @friends_of_friends = user.friends_of_friends.take(3)
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
