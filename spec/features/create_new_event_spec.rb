require 'spec_helper'

describe "Event" do

  it "allows me to make a new event" do
    visit root_path
    login
    click_on "Create A New Playdate"

    expect(current_path).to eq(new_event_path)
    expect(page).to have_content("Make a New PlayDate")
    fill_in "Name", with: "Football with kids"
    fill_in "Description", with: "x" * 26
    fill_in "Venue", with: "gSchool"
    fill_in "Street address", with: "1062 Delaware st"
    fill_in "City", with: "Denver"
    fill_in "State", with: "CO"
    fill_in "Zipcode", with: "80204"
    select "2013", from: "event[starts_at(1i)]"
    select "June", from: "event[starts_at(2i)]"
    select "24",   from: "event[starts_at(3i)]"
    click_on "Create Playdate"

    expect(Location.count).to eq(1)
    expect(page).to have_text("Event successfully created!")
    expect(page).to have_content("Football with kids")
  end
end
