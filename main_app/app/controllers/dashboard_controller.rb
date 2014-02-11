class DashboardController < ApplicationController

  def index
    if current_user
      @friends = current_user.friends

      friends_of_friends = current_user.friends.map(&:friends).flatten
      @friends_of_friends = friends_of_friends.reject {|friend| friend.id == current_user.id}
      @general_public = []
    else
      redirect_to "http://localhost:3002"
    end

  end

end
