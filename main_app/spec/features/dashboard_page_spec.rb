require 'spec_helper'

describe "dashboard page" do

  it "can view the page" do
    login
    expect(current_path).to eq('/')
  end

  it "has a link to create a playdate" do
    login
    within('.navbar') do
      expect(page).to have_content('Create A New Playdate')
    end
  end

end
