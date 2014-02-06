class SessionsController < ApplicationController

  def create
    auth = env["omniauth.auth"]
    cookies.signed[:provider] = [auth.provider, "hello"]
    cookies.signed[:uid] = {:value => [auth.uid, "hello"]}
    cookies.signed[:name] = [auth.info.name, "hello"]
    cookies.signed[:oauth_token] = [auth.credentials.token, "hello"]
    cookies.signed[:oauth_expires_at] = [Time.at(auth.credentials.expires_at), "hello"]
    redirect_to "http://localhost:3000"
  end
end
