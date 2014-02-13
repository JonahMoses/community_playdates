class UsersController < ApplicationController
  def create
    user = User.from_omniauth(user_params)
    if user.persisted?
      user.find_avatar
      user.find_large_avatar
    end
    send_json(user, 201)
  end

  def show
    user = User.find(params[:id])
    send_json(user)
  end

  def send_json(input, status_code = 200)
    if input
      render json: input, :status => status_code
    else
      render json: {}, :status => 500
    end
  end

  def all_friend_data
    user = User.find(params[:id])
    package = {friends: user.friends_on_community_playdates,
              friends_of_friends: user.friends_of_friends}
    send_json(package, 200)
  end

  def friends
    user = User.find(params[:id])
    send_json(user.friends_on_community_playdates)
  end

  private

  def user_params
    params.require(:user).permit(:provider, :name, :uid, :oauth_token, :oauth_expires_at, :email)
  end
end
