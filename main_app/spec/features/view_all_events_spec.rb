require 'spec_helper'

describe "view all events page" do

  it "shows all active events" do # order of the test's contents is necessary, do not switch
    location = FactoryGirl.create(:location)
    role = FactoryGirl.create(:role, identity: "creator")
    login
    user = User.last
    4.times do |n|
      event = FactoryGirl.create(:event, name: "event:#{n}", location_id: location.id)
      FactoryGirl.create(:registration, user_id: user.id, role_id: role.id, event_id: event.id)
    end
    visit root_path
    expect(Event.count).to eq 4
    click_on("View All Playdates")
    expect(current_path).to eq('/events')
    expect(page).to have_content('event:1')
    expect(page).to have_content('event:2')
    expect(page).to have_content('event:3')
  end
end

