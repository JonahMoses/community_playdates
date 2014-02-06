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
end
