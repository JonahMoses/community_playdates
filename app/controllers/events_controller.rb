class EventsController < ApplicationController
  def new
    @event = Event.new
    @location = Location.new
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @location = Location.create(location_params)
    @event = @location.events.create(event_params)
    if @event.save
      redirect_to @event, notice: "Playdate successfully created!"
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
