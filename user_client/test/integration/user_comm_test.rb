require 'test_helper'

class UserCommTest < ActionDispatch::IntegrationTest

  def setup
    Rails.application.config.secret_token
    VCR.eject_cassette
    VCR.turn_off!
  end

  test "POST '/users' sends created user as json objects" do

    User.any_instance.stubs(:find_avatar).returns("Noo")
    User.any_instance.stubs(:find_large_avatar).returns("Hoo")

    post '/users', {id: 1, user: {
      email: "agsiegert@hotmail.com",
      oauth_expires_at: "2014-04-12 04:18:51",
      provider: "facebook",
      uid: "536753365",
      oauth_token: "CAADOUxTaZBssBAEbIatemoZBC8",
      name: "Antony Siegert"
    }}

    user_json = JSON.parse(response.body)

    assert_equal 12, user_json.count
    assert_equal "Antony Siegert", user_json["name"]
    assert_equal "agsiegert@hotmail.com", user_json["email"]
    assert_equal "facebook", user_json["provider"]
    assert_equal "536753365", user_json["uid"]

  end

  test "GET /users/:id returns the user as a json object" do
    User.any_instance.stubs(:find_avatar).returns("Noo")
    User.any_instance.stubs(:find_large_avatar).returns("Hoo")

    id = 1
    User.create(email: "agsiegert@hotmail.com", oauth_expires_at: "2014-04-12 04:18:51", provider: "facebook", uid: "536753365", oauth_token: "CAADOUxTaZBssBAEbIatemoZBC8", name: "Antony Siegert")
    get "/users/#{id}"

    user_json = JSON.parse(response.body)

    assert_equal 12, user_json.count
    assert_equal "Antony Siegert", user_json["name"]
    assert_equal "agsiegert@hotmail.com", user_json["email"]
    assert_equal "facebook", user_json["provider"]
    assert_equal "536753365", user_json["uid"]
  end

end
