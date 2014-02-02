require 'spec_helper'

describe "User Profile Page" do

  it "displays a user's information" do
    login
    user = User.last
    within('.navbar-collapse') do
      click_on user.name
    end
    within('#user-profile') do
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.created_at.strftime("%m/%d/%Y"))
    end
  end

  it "displays links to that user's events" do
    login
    user = User.last
    event = FactoryGirl.create(:event)
    event2 = FactoryGirl.create(:event, name: "So much fun!")
    role = FactoryGirl.create(:role, identity: 'creator')
    role2 = FactoryGirl.create(:role, identity: 'attendee')
    FactoryGirl.create(:registration, user_id: user.id,
                        event_id: event.id, role_id: role.id)
    FactoryGirl.create(:registration, user_id: user.id,
                        event_id: event.id, role_id: role2.id)
    visit root_path
    within('.navbar-collapse') do
      click_on user.name
    end
    within('#user-profile') do
      expect(page).to have_content("Created Events")
    end

    within('#created-events') do
      expect(page).to have_content(user.created_events.first.name)
      expect(page).to_not have_content(event2.name)
    end

    within('#attending-events') do
      expect(page).to have_content(user.created_events.first.name)
    end
  end

end
