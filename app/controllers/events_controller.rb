class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: "Event successfully created!"
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:description, :name, :location, :starts_at, )
  end
end
