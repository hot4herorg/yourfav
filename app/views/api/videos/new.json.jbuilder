json.extract! @api_video, :url, :valid?, :site_id, :key, :embed_code, :title, :thumb_url, :thumb_array
# json.set! 'site_name', Site.find(@api_video.site_id).try(:name)
