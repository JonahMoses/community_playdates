class UsersController < ApplicationController

  def show
    @user = UserClient.find(params[:id])
    @large_avatar = @user.find_large_avatar
  end
end
