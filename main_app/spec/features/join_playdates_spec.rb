require 'spec_helper'

describe "join a playdate page" do

  it "is possible to join same playdate once" do
    location = FactoryGirl.create(:location)
    user = FactoryGirl.create(:user)
    role = FactoryGirl.create(:role, identity: "creator")
    event = Event.create(name: "Yoo", location_id: location.id)
    FactoryGirl.create(:registration, user_id: user.id, role_id:role.id, event_id: event.id)

    login

    FactoryGirl.create(:role, identity: "attendee")

    click_on "View All Playdates"
    within("#event_#{event.id}") do
      expect(page).to have_link("Join Playdate")
      click_on "Join Playdate"
    end

    expect(event.attendees.count).to eq 1

    within("#event_#{event.id}") do
      expect(page).to have_link("Join Playdate")
      click_on "Join Playdate"
    end
    expect(event.attendees.count).to eq 1
  end
end

