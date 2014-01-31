require 'spec_helper'

describe Registration do
  it "returns true if a user is already registered for event" do
    event = FactoryGirl.create(:event)
    role = FactoryGirl.create(:role)
    user = FactoryGirl.create(:user)
    registration = FactoryGirl.create(:registration, user_id: user.id, event_id: event.id, role_id: role.id)

    expect(registration.is_enlisted?).to be_true
  end

  it "returns false if a user does not exist" do
    registration = FactoryGirl.create(:registration, user_id: nil)

    expect(registration.is_enlisted?).to be_false
  end
end
