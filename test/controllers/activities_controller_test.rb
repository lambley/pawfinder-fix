require "test_helper"

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get activities_index_url
    assert_response :success
  end

  test "should get new" do
    get activities_new_url
    assert_response :success
  end

  test "should get create" do
    get activities_create_url
    assert_response :success
  end
end
