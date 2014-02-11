require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  def test_it_exists
    assert Friend
  end

  def test_it_gets_friends_picture
    VCR.use_cassette('friends_picture') do
      friend = Friend.new(
                "JonahMoses",
                "100000161048479",
                "CAADOUxTaZBssBAFceDXGewdq9DDP9vXldkZBeJjF1TK3snRDrZBhbA0KZA25V4OtVNAWaXfuJp9Kg1aQwKKdsH5RCDl1MGt235p0AdJwoZBDorUnwJXxrZCcwkVGTiO4d3hwjMDs9hH7trc4Ey2RZCzosRTnz53NlcoWsBKxYciDWZBf22XZCRAHwfAvEBmIcBlMZD"                      )
      refute_nil friend.picture_url
      assert_equal friend.picture_url, "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash1/t5/368994_100000161048479_1464730155_q.jpg"
    end
  end
end



# friend = Friend.new(
#               name: "Kevin Morrison Powell"],
#               id: "503528568",
#               @facebook)
