require 'spec_helper'

describe "Event" do

  before(:each) do
    Role.create(identity: 'creator')
    Role.create(identity: 'attendee')
  end

  it "allows me to make a new event" do

    visit root_path

    login

    click_on "Create A New Playdate"

    expect(current_path).to eq(new_event_path)
    expect(page).to have_content("Make a New Playdate")
    fill_in "event_name", with: "Soccer with kids"
    fill_in "Description", with: "fun " * 10
    fill_in "venue-name", with: "gSchool"
    fill_in "street-address", with: "1062 Delaware st"
    fill_in "event-city", with: "Denver"
    fill_in "event-state", with: "CO"
    fill_in "event-zipcode", with: "80204"
    fill_in "event[date]", with: "2/28/2014"
    fill_in "event[start_time]", with: "9:00 AM"
    fill_in "event[end_time]", with: "9:30 AM"
    click_on "Create Playdate"

    expect(Location.count).to eq(1)
    expect(page).to have_text("Playdate successfully created!")
    expect(page).to have_content("Soccer with kids")

    current_user = User.last
    event = Event.last
    expect(event.creator).to eq current_user
    #expect(page).to have_content "Created by #{current_user.name}"
  end
end
