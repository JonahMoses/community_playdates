require "spec_helper"

describe "An Event" do

  it "name cannot be blank" do
    event = FactoryGirl.build(:event, name: nil)

    expect(event.valid?).to be_false
    expect(event.errors[:name].any?).to be_true
  end

  it "returns all of its attendees" do
    event = FactoryGirl.create(:event)
    role = FactoryGirl.create(:role, identity: "attendee")
    FactoryGirl.create(:registration, event_id: event.id, role_id: role.id)

    expect(event.attendees.count).to eq 1
  end

  it "returns the creator" do
    event = FactoryGirl.create(:event)
    role = FactoryGirl.create(:role, identity: "creator")
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:registration, user_id: user.id, event_id: event.id, role_id: role.id)

    expect(event.creator.name).to eq "Adam"
  end

end

