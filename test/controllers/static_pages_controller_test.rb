require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get video_not_found" do
    get :video_not_found
    assert_response :success
  end

end
