require 'test_helper'

class VideoStarsControllerTest < ActionController::TestCase
  setup do
    @video_star = video_stars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:video_stars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create video_star" do
    assert_difference('VideoStar.count') do
      post :create, video_star: {  }
    end

    assert_redirected_to video_star_path(assigns(:video_star))
  end

  test "should show video_star" do
    get :show, id: @video_star
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @video_star
    assert_response :success
  end

  test "should update video_star" do
    patch :update, id: @video_star, video_star: {  }
    assert_redirected_to video_star_path(assigns(:video_star))
  end

  test "should destroy video_star" do
    assert_difference('VideoStar.count', -1) do
      delete :destroy, id: @video_star
    end

    assert_redirected_to video_stars_path
  end
end
