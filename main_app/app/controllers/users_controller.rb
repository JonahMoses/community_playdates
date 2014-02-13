class UsersController < ApplicationController

  def show
    if params[:id] == current_user.id
      @user = current_user
    else
      @user = UserClient.get_all_friend_data(params[:id])
    end

    @large_avatar = @user.large_avatar
    # @date = @user.events.map(&:date)
    @events = Event.sorted_by_day(@user)
    @friends = @user.friends
    @friends_of_friends = @user.friends_of_friends
  end

  def friends
    user = User.find(params[:id])
    @friends = user.friends_on_community_playdates
  end
end
