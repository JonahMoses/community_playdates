class UsersController < ApplicationController

  def show
    @user = current_user
    @large_avatar = @user.large_avatar
  end

  def friends
    user = User.find(params[:id])
    @friends = user.friends_on_community_playdates
    fail
  end
end
