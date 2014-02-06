class LandingController < ApplicationController
  def index
    @cookies = cookies[:name]
  end
end
