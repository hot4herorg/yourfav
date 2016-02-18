json.array!(@videos) do |video|
  json.extract! video, :id, :url, :key, :title, :site_id
  json.url video_url(video, format: :json)
end
