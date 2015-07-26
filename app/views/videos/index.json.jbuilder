json.array!(@videos) do |video|
  json.extract! video, :id, :title, :key, :site_id
  json.url video_url(video, format: :json)
end
