class SessionsController < ApplicationController

  def create
    auth = env["omniauth.auth"]
    cookies.signed[:provider]         = auth.provider
    cookies.signed[:uid]              = auth.uid
    cookies.signed[:name]             = auth.info.name
    cookies.signed[:oauth_token]      = auth.credentials.token
    cookies.signed[:oauth_expires_at] = Time.at(auth.credentials.expires_at)
    cookies.signed[:email]            = auth.info.email
    redirect_to "http://localhost:3000"
  end

  def destroy
    cookies[:user_id]                 = nil
    cookies.signed[:provider]         = nil
    cookies.signed[:uid]              = nil
    cookies.signed[:name]             = nil
    cookies.signed[:oauth_token]      = nil
    cookies.signed[:oauth_expires_at] = nil
    cookies.signed[:email]            = nil
    redirect_to root_path
  end
end
