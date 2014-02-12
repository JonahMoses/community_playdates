class LandingController < ApplicationController
  def index
    @cookies = cookies.signed[:name]
  end
end
