json.array!(@video_stars) do |video_star|
  json.extract! video_star, :id
  json.url video_star_url(video_star, format: :json)
end
