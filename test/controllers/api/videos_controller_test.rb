require 'test_helper'

class Api::VideosControllerTest < ActionController::TestCase
  setup do
    @api_video = api_videos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_videos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_video" do
    assert_difference('Api::Video.count') do
      post :create, api_video: {  }
    end

    assert_redirected_to api_video_path(assigns(:api_video))
  end

  test "should show api_video" do
    get :show, id: @api_video
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_video
    assert_response :success
  end

  test "should update api_video" do
    patch :update, id: @api_video, api_video: {  }
    assert_redirected_to api_video_path(assigns(:api_video))
  end

  test "should destroy api_video" do
    assert_difference('Api::Video.count', -1) do
      delete :destroy, id: @api_video
    end

    assert_redirected_to api_videos_path
  end
end
