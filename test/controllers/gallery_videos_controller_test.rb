require 'test_helper'

class GalleryVideosControllerTest < ActionController::TestCase
  setup do
    @gallery_video = gallery_videos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gallery_videos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gallery_video" do
    assert_difference('GalleryVideo.count') do
      post :create, gallery_video: {  }
    end

    assert_redirected_to gallery_video_path(assigns(:gallery_video))
  end

  test "should show gallery_video" do
    get :show, id: @gallery_video
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gallery_video
    assert_response :success
  end

  test "should update gallery_video" do
    patch :update, id: @gallery_video, gallery_video: {  }
    assert_redirected_to gallery_video_path(assigns(:gallery_video))
  end

  test "should destroy gallery_video" do
    assert_difference('GalleryVideo.count', -1) do
      delete :destroy, id: @gallery_video
    end

    assert_redirected_to gallery_videos_path
  end
end
