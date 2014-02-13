require "test_helper"

describe Friendship do
  before do
    @friendship = Friendship.new
  end

  it "must be valid" do
    @friendship.valid?.must_equal true
  end
end
