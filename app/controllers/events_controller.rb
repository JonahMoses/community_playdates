class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @location = Location.new
  end

  def create
    @event = Event.new(event_params)
    @location = Location.new(location_params)
    if @event.valid? && @location.valid?
      @event.save
      @location.save
      @event.update_attributes(location_id: @location.id)
      redirect_to @event, notice: "Playdate successfully created!"
    else
      render :new
    end
  end

  # def edit

  # end

  # def update

  # end

  # def destroy

  # end

  private

  def event_params
    params.require(:event).permit(:description, :name, :location, :starts_at )
  end

  def location_params
    params.require(:location).permit(:venue, :street_address, :city, :state, :zipcode )
  end

  def create
    fail
  end
end
