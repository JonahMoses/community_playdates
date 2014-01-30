require 'spec_helper'

describe "join a playdate page" do

  it "is possible to join a playdate" do
    Role.create(identity: "attendee")
    location = Location.create(location_attributes)
    event = Event.create(event_attributes(location_id: location.id))
    login
    click_on "View All Playdates"
    within("#event_#{event.id}") do
      expect(page).to have_link("Join Playdate")
      click_on "Join Playdate"
    end
    expect(event.attendees.count).to eq 1
  end
end

