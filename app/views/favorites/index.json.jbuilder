json.array!(@favorites) do |favorite|
  json.extract! favorite, :id, :user_id, :video_id, :enabled, :position, :plays
  json.url favorite_url(favorite, format: :json)
end
