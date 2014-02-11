require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def test_should_get_create
    VCR.use_cassette('user_create') do
      assert_difference('User.count') do
        post :create, user: {name: 'John Doe'}
      end
      assert_response :success
    end
  end

  def test_it_shows_a_user
    User.create!
    get :show, :id => 1
    assert_response :success
  end

  def test_it_gets_users_friends
    VCR.use_cassette('user_get_friends') do
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
      get :friends, :id => user.id
      assert_response :success
    end
  end
end

