require 'spec_helper'

describe Friend do
  it "is created with valid params" do
    friend = Friend.new("Billy", 3, "GABCDEF...")
    expect(friend.name).to eq("Billy")
    expect(friend.id).to eq(3)
    expect(friend.token).to eq("GABCDEF...")
  end

  it "can get the picture" do
    friend = Friend.new("Billy", 3, "GABCDEF...")
    friend.token.stub(:get_picture).and_return("success!")
    expect(friend.picture_url).to eq("success!")
  end
end
