require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
  end

  test "should get search" do
    get static_pages_search_url
    assert_response :success
  end

  test "should get result" do
    get static_pages_result_url
    assert_response :success
  end

end
