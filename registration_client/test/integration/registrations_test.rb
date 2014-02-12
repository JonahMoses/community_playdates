require 'test_helper'

class RegistrationsTest < ActionDispatch::IntegrationTest

  def login
    secret_token = Rails.application.config.secret_token
    cookies[:provider] = ActiveSupport::MessageVerifier.new(secret_token).generate(1)
    cookies[:uid] = ActiveSupport::MessageVerifier.new(secret_token).generate(1)
    cookies[:name] = ActiveSupport::MessageVerifier.new(secret_token).generate(1)
    cookies[:oauth_token] = ActiveSupport::MessageVerifier.new(secret_token).generate(1)
    cookies[:oauth_expires_at] = ActiveSupport::MessageVerifier.new(secret_token).generate(1)
    cookies[:email] = ActiveSupport::MessageVerifier.new(secret_token).generate(1)
  end

  test "GET /users/registrations/:id returns json for the user's registrations" do
    #set cookies for fake values
    login

    #create a registration with a known user_id value
    user_id = 1
    Registration.create!(user_id: user_id, role_id: 2, event_id: 3)

    #make the get request
    get "/registrations/users/#{user_id}?auth_id=#{ENV['APP_CONFIRMATION']}"

    #parse json like client app would parse it
    response_json = JSON.parse(response.body)

    #assert that the json response is correct for user with id 1
    first_registration = response_json.first
    assert_equal 1, response_json.count

    assert_equal 1, first_registration["user_id"]
    assert_equal 2, first_registration["role_id"]
    assert_equal 3, first_registration["event_id"]
  end

  test "GET /registrations/roles/:id/:event_id returns json for roles registrations" do
    #set fake values for cookies
    login

    #create a registration, with a known role_id
    role_id = 1
    Registration.create!(role_id: role_id, user_id: 2, event_id: 3)

    #perform the get request
    get "/registrations/roles/#{role_id}/#{3}?auth_id=#{ENV['APP_CONFIRMATION']}"

    #parse the json like the client app would
    response_json = JSON.parse(response.body)
    first_registration = response_json.first

    assert_equal 1, response_json.count
    assert_equal 1, first_registration["role_id"]
    assert_equal 2, first_registration["user_id"]
    assert_equal 3, first_registration["event_id"]
  end

  test "post '/registrations' create a new registration" do
    #set fake values for cookies
    login

    post '/registrations',  {user_id: 1, role_id: 2, event_id: 3, auth_id: ENV['APP_CONFIRMATION']}

    response_json = JSON.parse(response.body)

    assert_equal 6, response_json.count
    assert_equal 1, response_json["user_id"]
    assert_equal 2, response_json["role_id"]
    assert_equal 3, response_json["event_id"]
  end

  test "delete '/registrations/:id' destroys a existing registration" do

    #set fake values for cookies
    login

    #create a registration to be destroyed
    id = 1
    Registration.create!(id: id, role_id: 2, user_id: 2, event_id: 3)


    delete "/registrations/#{id}?auth_id=#{ENV['APP_CONFIRMATION']}"
    assert_response :no_content
    assert_empty response.body
  end
end
