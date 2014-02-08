class UsersController < ApplicationController
  def create
    user = User.from_omniauth(user_params)
    if user.persisted?
      #user.find_avatar
    end

    send_json(user, 201)
  end

  def send_json(input, status_code = 200)
    if input
      render json: input, :status => status_code
    else
      render json: {}, :status => 500
    end
  end

  private

  def user_params
    params.require(:user).permit(:provider, :name, :uid, :oauth_token, :oauth_expires_at, :email)
  end
end
