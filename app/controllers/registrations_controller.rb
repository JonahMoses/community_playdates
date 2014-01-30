class RegistrationsController < ApplicationController

  def create
    event = Event.find(params[:event_id])
    role = Role.find_by(identity: "attendee")
    Registration.create(role_id: role.id, user_id: current_user.id, event_id: event.id)
    redirect_to event_path(event)
  end
end
