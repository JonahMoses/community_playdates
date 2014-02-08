class UsersController < ApplicationController

  def show
    @user = current_user
    @large_avatar = @user.large_avatar
  end
end
