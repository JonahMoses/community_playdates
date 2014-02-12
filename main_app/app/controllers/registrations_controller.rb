class RegistrationsController < ApplicationController

  def create
    role = Role.find_by(identity: "attendee")
    RegistrationClient.create(role.id, current_user.id, params[:event_id])
    redirect_to event_path(params[:event_id])
  end

end
