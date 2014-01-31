class RegistrationsController < ApplicationController

  def create
    event = Event.find(params[:event_id])
    role = Role.find_by(identity: "attendee")
    if event.creator != current_user
      Registration.create(role_id: role.id, user_id: current_user.id, event_id: event.id)
      redirect_to event_path(event)
    else
      redirect_to events_path, notice: "This is your playdate"
    end
  end
end
