json.array!(@gallery_videos) do |gallery_video|
  json.extract! gallery_video, :id
  json.url gallery_video_url(gallery_video, format: :json)
end
