require 'spec_helper'

describe Registration do
  it "returns true if a user is already registered for event" do
    event = FactoryGirl.create(:event)
    role = FactoryGirl.create(:role)
    user = FactoryGirl.create(:user)
    registration = FactoryGirl.create(:registration, user_id: user.id, event_id: event.id, role_id: role.id)
    reg = FactoryGirl.create(:registration, user_id: user.id, event_id: event.id, role_id: role.id)

    expect(registration.is_enlisted?(reg)).to be_true
  end

  it "returns false if a user is not registered" do
    registration = FactoryGirl.create(:registration, user_id: 1)
    reg = FactoryGirl.create(:registration, user_id: 2 )

    expect(registration.is_enlisted?(reg)).to be_false
  end
end
