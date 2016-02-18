require 'test_helper'

class Api::SitesControllerTest < ActionController::TestCase
  setup do
    @api_site = api_sites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_sites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_site" do
    assert_difference('Api::Site.count') do
      post :create, api_site: {  }
    end

    assert_redirected_to api_site_path(assigns(:api_site))
  end

  test "should show api_site" do
    get :show, id: @api_site
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_site
    assert_response :success
  end

  test "should update api_site" do
    patch :update, id: @api_site, api_site: {  }
    assert_redirected_to api_site_path(assigns(:api_site))
  end

  test "should destroy api_site" do
    assert_difference('Api::Site.count', -1) do
      delete :destroy, id: @api_site
    end

    assert_redirected_to api_sites_path
  end
end
