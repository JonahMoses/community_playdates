class UsersController < ApplicationController

  def show
    @user = UserClient.get_user(params[:id])
    @large_avatar = @user.large_avatar
    @date = @user.events.map(&:date)
    @events = Event.sorted_by_day(@user)
  end

  def friends
    user = User.find(params[:id])
    @friends = user.friends_on_community_playdates
  end
end
