class RegistrationsController < ApplicationController

  def create
    event = Event.find(params[:event_id])
    role = Role.find_by(identity: "attendee")
    if current_user == event.creator
      redirect_to events_path, notice: "You cannot join events you have created!"
    else
      Registration.create(role_id: role.id, user_id: current_user.id, event_id: event.id)
      redirect_to event_path(event)
    end
  end
end
