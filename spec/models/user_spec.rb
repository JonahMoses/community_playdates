require 'spec_helper'

describe User do

  before :all do
    @user = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user, :uid => 432)
  end


  it "finds the avatar" do
    Koala::Facebook::API.any_instance.stub(:get_picture).and_return("https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn2/186282_4404823_1982702436_q.jpg")
    expect(@user.find_avatar).to be
  end

  it "knows who its friends are" do
    Koala::Facebook::API.any_instance.stub(:get_connection).and_return([
      {"name" => "Charlie Miller",
      "id" => "432"},
      {"name" => "Mike Manco-Johnson",
      "id" => "24249"}
      ])
    expect(@user.all_friends).to be_a_kind_of(Array)
    expect(@user.all_friends.first).to be_a_kind_of(Friend)
  end
end
