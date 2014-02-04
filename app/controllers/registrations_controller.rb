class RegistrationsController < ApplicationController

  def create
    event = Event.find(params[:event_id])
    enlisted = event.registrations.find {|r| r.is_enlisted?(r)}
    role = Role.find_by(identity: "attendee")
    if current_user == event.creator || (enlisted)
      redirect_to events_path, alert: "You are already registered for this event"
    else
      Registration.create(role_id: role.id, user_id: current_user.id, event_id: event.id)
      redirect_to event_path(event)
    end
  end
end
