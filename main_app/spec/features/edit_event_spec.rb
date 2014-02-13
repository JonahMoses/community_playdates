require 'spec_helper'

describe "Editing Event" do
  before(:each) do
    Role.create(identity: 'creator')
    Role.create(identity: 'attendee')
  end

  it "allows user to edit event they created" do
    VCR.use_cassette "edit_event" do
        user = UserClient.create!(
            email: "agsiegert@hotmail.com",
            username: nil,
            provider: "facebook",
            uid: "536753365",
            name: "Antony Siegert",
            oauth_token: "CAADOUxTaZBssBAEbIatemoZBC8WnBkbD6QiZA6hHrK0gFYZCp6s99oVXou6QgNgrP4kWZBepngLU6ugfkZBlhB1anVLOBecvApHEcEL3kZBA43JEitpqMiZCkdNLAUSmm5Jfg2Airb11NvnSKvC0BdVVt8vlDZBzlZBre5Q6F3MfNLZCyKfEncgPZBANzvjugCMFE5IZD",
            oauth_expires_at: "2014-04-12 04:18:51",
            avatar: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash2/t5/186388_536753365_1031627958_q.jpg"
            )

        visit root_path

        click_on "Sign in with Facebook"


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

end
