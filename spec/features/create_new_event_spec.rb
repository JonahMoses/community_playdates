require 'spec_helper'

describe "Event" do
  it "allows me to make a new event" do
    visit root_path
    login
    click_on "Create A New Playdate"

    expect(current_path).to eq(new_event_path)
    expect(page).to have_content("Make a New Play Date")

   fill_in "Name", with: "Football with kids"
   fill_in "Description", with: "x" * 26
   fill_in "Location", with: "gSchool"
   select "2013", from: "event[starts_at(1i)]"
   select "June", from: "event[starts_at(2i)]"
   select "24",   from: "event[starts_at(3i)]"
   click_on "Create Playdate"

   expect(page).to have_text("Event successfully created!")
   expect(page).to have_content("Football with kids")
 end

  it "adds a default image if none is specified" do

    visit root_path
    login
    click_on "Create A New Playdate"

    fill_in "Name", with: "Football Kids"
    fill_in "Description", with: "D" * 25
    fill_in "Location", with: "gSchool"
    select "2013", from: "event[starts_at(1i)]"
    select "June", from: "event[starts_at(2i)]"
    select "24",   from: "event[starts_at(3i)]"
    click_on "Create Playdate"

  end
end
