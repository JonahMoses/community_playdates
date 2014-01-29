class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    # @event = Event.create(event_params)
    # @event.location.create(location_params)
    @location = Location.create(location_params)
    @event = @location.events.create(event_params)
    if @event.save
      redirect_to @event, notice: "Event successfully created!"
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:description, :name, :location, :starts_at )
  end

  def location_params
    params.require(:location).permit(:venue, :street_address, :city, :state, :zipcode )
  end
end
