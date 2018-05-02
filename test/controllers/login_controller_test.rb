require 'test_helper'

class LoginControllerTest < ActionDispatch::IntegrationTest
  test "should get createUser" do
    get login_createUser_url
    assert_response :success
  end

end
