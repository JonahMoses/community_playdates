require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase

  def test_it_exists
    assert Registration
  end

  def test_it_creates_registration_with_valid_attritbutes
    registration = Registration.create(user_id: 1, role_id: 1, event_id: 1)
    assert_instance_of Registration, registration
    assert_equal 1, registration.user_id
    assert_equal 1, registration.role_id
  end

  def test_it_returns_for_users_registration
    registration = Registration.create(user_id: 1, role_id: 1, event_id: 1)
    assert_equal registration, Registration.for_user(1).first
  end

  def test_it_find_registration_by_event_role
    registration = Registration.create(user_id: 1, role_id: 1, event_id: 1)
    assert_equal registration, Registration.by_event_role(1,1).first
  end
end
