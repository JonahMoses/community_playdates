require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_it_exists
    assert User
  end

  def test_it_can_create_a_user_with_supplied_attributes
    user = User.create!(
          email: "agsiegert@hotmail.com",
          username: nil,
          provider: "facebook",
          uid: "536753365",
          name: "Antony Siegert",
          oauth_token: "CAADOUxTaZBssBAEZBrs08IVr4d8XwhtfZAOB4J9sy6lguXRryd...",
          oauth_expires_at: "2014-03-31 17:49:46",
          avatar: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash2/t5/186388_536753365_1031627958_q.jpg"
          )
    assert_equal "facebook", user.provider
    assert_equal "agsiegert@hotmail.com", user.email
    assert_equal "Antony Siegert", user.name
  end

  def test_it_returns_all_friends
    VCR.use_cassette('users_friends') do
      user = User.create!(
            email: "agsiegert@hotmail.com",
            username: nil,
            provider: "facebook",
            uid: "536753365",
            name: "Antony Siegert",
            oauth_token: "CAADOUxTaZBssBAEbIatemoZBC8WnBkbD6QiZA6hHrK0gFYZCp6s99oVXou6QgNgrP4kWZBepngLU6ugfkZBlhB1anVLOBecvApHEcEL3kZBA43JEitpqMiZCkdNLAUSmm5Jfg2Airb11NvnSKvC0BdVVt8vlDZBzlZBre5Q6F3MfNLZCyKfEncgPZBANzvjugCMFE5IZD",
            oauth_expires_at: "2014-04-12 04:18:51",
            avatar: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash2/t5/186388_536753365_1031627958_q.jpg"
            )

      assert_equal 31, user.all_friends.count
    end
  end

  def test_it_finds_friends_on_community_playdates
    VCR.use_cassette('users_friends') do
      user = User.create!(
            email: "agsiegert@hotmail.com",
            username: nil,
            provider: "facebook",
            uid: "536753365",
            name: "Antony Siegert",
            oauth_token: "CAADOUxTaZBssBAEbIatemoZBC8WnBkbD6QiZA6hHrK0gFYZCp6s99oVXou6QgNgrP4kWZBepngLU6ugfkZBlhB1anVLOBecvApHEcEL3kZBA43JEitpqMiZCkdNLAUSmm5Jfg2Airb11NvnSKvC0BdVVt8vlDZBzlZBre5Q6F3MfNLZCyKfEncgPZBANzvjugCMFE5IZD",
            oauth_expires_at: "2014-04-12 04:18:51",
            avatar: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash2/t5/186388_536753365_1031627958_q.jpg"
            )
      friend = User.create!(
                      name:"JonahMoses",
                      uid:"100000161048479"
                      )
      assert_equal 1, user.friends_on_community_playdates.count
    end
  end

  def test_it_finds_friends_of_friends
    VCR.use_cassette('friends_of_friends') do
      user = User.create!(
            email: "agsiegert@hotmail.com",
            username: nil,
            provider: "facebook",
            uid: "536753365",
            name: "Antony Siegert",
            oauth_token: "CAADOUxTaZBssBAEbIatemoZBC8WnBkbD6QiZA6hHrK0gFYZCp6s99oVXou6QgNgrP4kWZBepngLU6ugfkZBlhB1anVLOBecvApHEcEL3kZBA43JEitpqMiZCkdNLAUSmm5Jfg2Airb11NvnSKvC0BdVVt8vlDZBzlZBre5Q6F3MfNLZCyKfEncgPZBANzvjugCMFE5IZD",
            oauth_expires_at: "2014-04-12 04:18:51",
            avatar: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash2/t5/186388_536753365_1031627958_q.jpg"
            )
      friend = User.create!(
                email: "jonahkmoses@gmail.com",
                provider: "facebook",
                uid:"100000161048479",
                name:"JonahMoses",
                oauth_token: "CAADOUxTaZBssBAFceDXGewdq9DDP9vXldkZBeJjF1TK3snRDrZBhbA0KZA25V4OtVNAWaXfuJp9Kg1aQwKKdsH5RCDl1MGt235p0AdJwoZBDorUnwJXxrZCcwkVGTiO4d3hwjMDs9hH7trc4Ey2RZCzosRTnz53NlcoWsBKxYciDWZBf22XZCRAHwfAvEBmIcBlMZD",
                oauth_expires_at: "2014-04-12 05:11:12",
                      )

        friendoffriend = User.create!(
                          name:"David Ingber",
                          uid:"1052"
                                    )

      assert_equal 1, user.friends_of_friends.count
    end
  end

  def test_it_can_find_avatar
    VCR.use_cassette('user_koala') do
      user = User.create!(
            email: "agsiegert@hotmail.com",
            username: nil,
            provider: "facebook",
            uid: "536753365",
            name: "Antony Siegert",
            oauth_token: "CAADOUxTaZBssBAEbIatemoZBC8WnBkbD6QiZA6hHrK0gFYZCp6s99oVXou6QgNgrP4kWZBepngLU6ugfkZBlhB1anVLOBecvApHEcEL3kZBA43JEitpqMiZCkdNLAUSmm5Jfg2Airb11NvnSKvC0BdVVt8vlDZBzlZBre5Q6F3MfNLZCyKfEncgPZBANzvjugCMFE5IZD",
            oauth_expires_at: "2014-04-12 04:18:51",
            avatar: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash2/t5/186388_536753365_1031627958_q.jpg"
            )
      refute_nil user.find_avatar
    end
  end

  def test_it_can_find_large_avatar
    VCR.use_cassette('user_koala_large') do
      user = User.create!(
            email: "agsiegert@hotmail.com",
            username: nil,
            provider: "facebook",
            uid: "536753365",
            name: "Antony Siegert",
            oauth_token: "CAADOUxTaZBssBAEbIatemoZBC8WnBkbD6QiZA6hHrK0gFYZCp6s99oVXou6QgNgrP4kWZBepngLU6ugfkZBlhB1anVLOBecvApHEcEL3kZBA43JEitpqMiZCkdNLAUSmm5Jfg2Airb11NvnSKvC0BdVVt8vlDZBzlZBre5Q6F3MfNLZCyKfEncgPZBANzvjugCMFE5IZD",
            oauth_expires_at: "2014-04-12 04:18:51",
            avatar: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash2/t5/186388_536753365_1031627958_q.jpg"
            )
      refute_nil user.find_large_avatar
    end
  end
end
