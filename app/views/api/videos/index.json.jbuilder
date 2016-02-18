json.array!(@api_videos) do |api_video|
  json.extract! api_video, :id
  json.url api_video_url(api_video, format: :json)
end
