class UsersController < ApplicationController

  def show
    @user = current_user
    @large_avatar = @user.large_avatar
    @date = current_user.events.map(&:date)
    events = current_user.events.each_with_object({}) do |event, hash|
      if hash[event.date]
        hash[event.date] << event
      else
        hash[event.date] = [event]
      end
    end
    h = {}
    events.each do |key, value|
      h[key] = value.sort_by { |e| e.start_time }
    end
    @events = h
  end

  def friends
    user = User.find(params[:id])
    @friends = user.friends_on_community_playdates
  end
end
