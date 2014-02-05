class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      user.find_avatar
      flash.notice      = "Signed in!"
      session[:user_id] = user.id
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to welcome_path
    end
  end

  alias_method :facebook, :all

end
