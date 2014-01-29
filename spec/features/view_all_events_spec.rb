require 'spec_helper'

describe "view all events page" do

  it "shows all active events" do
    location = Location.create(location_attributes)
    4.times do |n|
      Event.create(event_attributes(name: "event:#{n}", location_id: location.id))
    end
    expect(Event.count).to eq 4
    login
    click_on("View All Playdates")
    expect(current_path).to eq('/events')
    expect(page).to have_content('event:1')
    expect(page).to have_content('event:2')
    expect(page).to have_content('event:3')
  end
end

