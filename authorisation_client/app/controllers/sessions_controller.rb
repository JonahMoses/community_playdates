class SessionsController < ApplicationController
  def index
    @cookies = cookies[:name]
  end

  def new

  end

  def create
    cookies[:name] = {
      value: 'a yummy cookie',
      expires: 1.year.from_now
    }

    @cookies = cookies[:name]
    redirect_to index
  end
end
