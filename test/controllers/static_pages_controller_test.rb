require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get browser_extension" do
    get :browser_extension
    assert_response :success
  end

end
