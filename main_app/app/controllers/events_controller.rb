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
      role = Role.find_by(identity: "creator")
      RegistrationClient.create(role.id, current_user.id, @event.id)
      @event.update_attributes(location_id: @location.id)
      redirect_to @event, notice: "Playdate successfully created!"
    else
      render :new
    end
  end

  def edit
    if Event.find(params[:id]).creator == current_user
      @event = Event.find(params[:id])
      @location = Location.find(@event.location_id)
    else
      redirect_to events_path, alert: "Not your event"
    end
  end

  def update
    @event = Event.find(params[:id])
    @location = Location.find(@event.location_id)
    if @event.update(event_params) && @location.update(location_params)
      redirect_to event_path(@event), notice: "Playdate successfully updated"
    else
      render :edit
    end
  end

  # def destroy

  # end

  private

  def event_params
    params.require(:event).permit(:description, :name, :location, :start_time, :end_time, :date )
  end

  def location_params
    params.require(:location).permit(:venue, :street_address, :city, :state, :zipcode )
  end
end
