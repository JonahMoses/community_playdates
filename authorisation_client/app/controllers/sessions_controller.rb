class SessionsController < ApplicationController

  def create
    auth = env["omniauth.auth"]
    cookies.signed[:provider]         = auth.provider
    cookies.signed[:uid]              = auth.uid
    cookies.signed[:name]             = auth.info.name
    cookies.signed[:oauth_token]      = auth.credentials.token
    cookies.signed[:oauth_expires_at] = Time.at(auth.credentials.expires_at)
    cookies.signed[:email]            = auth.info.email
    if Rails.env.production?
      redirect_to "http://communityplaydates.com/"
    else
      redirect_to "http://localhost:3000"
    end
  end

  def destroy
    cookies[:user_id]                 = nil
    cookies.signed[:provider]         = nil
    cookies.signed[:uid]              = nil
    cookies.signed[:name]             = nil
    cookies.signed[:oauth_token]      = nil
    cookies.signed[:oauth_expires_at] = nil
    cookies.signed[:email]            = nil
    if Rails.env.production?
      redirect_to "http://communityplaydates.com/welcome"
    else
      redirect_to "http://localhost:3000"
    end
  end
end
