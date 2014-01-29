require 'spec_helper'

describe "dashboard page" do

  it "can view the page" do
    login
    expect(current_path).to eq('/')
  end

  it "has a link to create a playdate" do
    login
    within('.create-playdate') do
      expect(page).to have_link('Create a Playdate', href: new_playdate_path)
    end
  end

end
