require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase

  def test_it_sends_created_registrations_as_json
    registration = Registration.create!(user_id: 1, role_id: 1, event_id: 1)
    registration.inspect
    post :create, {user_id: registration.user_id,
                   role_id: registration.role_id,
                   event_id: registration.event_id,
                   auth_id: ENV['APP_CONFIRMATION']}

    assert_response :success
  end

end
