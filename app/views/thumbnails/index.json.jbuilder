json.array!(@thumbnails) do |thumbnail|
  json.extract! thumbnail, :id, :url, :video_id
  json.url thumbnail_url(thumbnail, format: :json)
end
