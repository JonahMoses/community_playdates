class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_filter :authenticate_user_info

  def authenticate_user_info
    process_request
  end

  def process_request
    if params[:auth_id] && hash(params[:auth_id])
      return true
    else
      render json: {}, :status => 403
    end
  end

  def hash(input)
    BCrypt::Password.create(ENV['APP_CONFIRMATION']) == input
  end

end
