class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    fail
  end
end
