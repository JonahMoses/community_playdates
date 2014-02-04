require 'spec_helper'

describe "Editing Event" do
  before(:each) do
    Role.create(identity: 'creator')
    Role.create(identity: 'attendee')
  end

  it "allows user to edit event they created" do
    visit root_path

    login

    location = FactoryGirl.create(:location)

    user = User.last

    event = Event.create(name: "Yoo", location_id: location.id)

    FactoryGirl.create(:registration, event_id: event.id, user_id: user.id, role_id: Role.first.id)

    visit edit_event_path(event)

    expect(current_path).to eq(edit_event_path(event))

    expect(page).to have_text("Editing #{event.name}")
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
    click_on "Submit Playdate"

    expect(current_path).to eq(event_path(event))
    expect(page).to have_text("Soccer with kids")
    expect(page).to have_text("gSchool")
  end

end
