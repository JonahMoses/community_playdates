class RegistrationsController < ApplicationController

  def create
    role = Role.find_by(identity: "attendee")
    RegistrationClient.create(role.id, current_user.id, params[:event_id])
    redirect_to event_path(params[:event_id])
  end

  def destroy
    response = RegistrationClient.destroy(params[:event_id], params[:user_id])
    redirect_to user_path(current_user.id)
  end

end
