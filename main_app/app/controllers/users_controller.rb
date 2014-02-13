class UsersController < ApplicationController

  def show
    @user = UserClient.get_all_friend_data(params[:id])
    @large_avatar = @user.large_avatar
    # @date = @user.events.map(&:date)
    @events = Event.sorted_by_day(@user)
    @friends = @user.friends
    @friends_of_friends = @user.friends_of_friends.uniq.reject {|f| f.id == @user.id}
  end

  def friends
    user = User.find(params[:id])
    @friends = user.friends_on_community_playdates
  end
end
