require 'test_helper'

class AuthTest < ActionDispatch::IntegrationTest
   test "POST '/user' creates or finds a user and sends it as json" do
     post '/user'
   end
end
