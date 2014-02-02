class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @large_avatar = @user.find_large_avatar
  end
end
