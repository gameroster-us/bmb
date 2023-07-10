require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get send_verification_code" do
    get registrations_send_verification_code_url
    assert_response :success
  end
end
