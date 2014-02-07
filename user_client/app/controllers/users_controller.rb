class UsersController < ApplicationController
  def create
    user = User.new(params[:provider], params[:name], params[:uid], params[:oauth_token], params[:oauth_expires_at], params[:email])
    if user.save
      User.create(user_params)
    end
  end

  private

  def user_params
    params.require(:user).permit(:provider, :name, :uid, :oauth_token, :oauth_expires_at, :email)
  end
end
