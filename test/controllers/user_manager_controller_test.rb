require "test_helper"

class UserManagerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_manager_index_url
    assert_response :success
  end

  test "should get update_user_type" do
    get user_manager_update_user_type_url
    assert_response :success
  end
end
