require 'spec_helper'

describe "dashboard page" do

  it "can view the page" do
    login
    expect(current_path).to eq('/')
  end

  xit "has a link to create a playdate" do
    login
    within('.create-playdate') do
      expect(page).to have_content('Create A New Playdate')
    end
  end

end
