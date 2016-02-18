json.array!(@thumbnails) do |thumbnail|
  json.extract! thumbnail, :id, :title, :caption, :alt, :image
  json.url thumbnail_url(thumbnail, format: :json)
end
