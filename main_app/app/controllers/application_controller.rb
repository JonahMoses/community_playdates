class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # before_filter :authenticate_user!, except: [:index, :show]
  before_filter :authenticate_user_info

private

  def authenticate_user_info
    if (cookies.signed[:provider] &&
        cookies.signed[:uid] &&
        cookies.signed[:name] &&
        cookies.signed[:oauth_token] &&
        cookies.signed[:oauth_expires_at] &&
        cookies.signed[:email])
      set_user
    else
      # cookies.delete
      redirect_to "http://localhost:3002"
    end
  end

  def current_user
    @current_user ||= set_user
  end

  def set_user
    auth = {provider:         cookies.signed[:provider],
            uid:              cookies.signed[:uid],
            name:             cookies.signed[:name],
            oauth_token:      cookies.signed[:oauth_token],
            oauth_expires_at: cookies.signed[:oauth_expires_at],
            email:            cookies.signed[:email]}
    user = User.from_omniauth(auth)
    if user.persisted?
      user.find_avatar
      flash.notice      = "Signed in!"
      session[:user_id] = user.id
      @current_user = user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to "http://localhost:3002"
    end
  end

  helper_method :current_user

end



