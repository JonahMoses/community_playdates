class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_filter :authenticate_user_info

  def authenticate_user_info
    # if (cookies.signed[:provider] &&
    #     cookies.signed[:uid] &&
    #     cookies.signed[:name] &&
    #     cookies.signed[:oauth_token] &&
    #     cookies.signed[:oauth_expires_at] &&
    #     cookies.signed[:email])
    #   true
    # else
    #   # cookies.delete
    #   redirect_to "http://localhost:3002"
    # end
    true
  end
end
