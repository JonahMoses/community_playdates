class RegistrationsController < ApplicationController
  respond_to :json

  def create
    registration = Registration.create(role_id: params[:role_id], user_id: params[:user_id], event_id: params[:event_id])
    send_json(registration, 201)
  end

  def role_registrations
    registrations = Registration.by_event_role(params[:id].to_i, params[:event_id].to_i)
    send_json(registrations)
  end

  def user_registrations
    registrations = Registration.for_user(params[:id].to_i)
    send_json(registrations)
  end

  def send_json(input, status_code = 200)
    if input
      render json: input, :status => status_code
    else
      render json: {}, :status => 500
    end
  end

  def destroy

   registration =  Registration.delete(params[:event_id], params[:user_id])
   send_json(registration, 204)
  end

end
