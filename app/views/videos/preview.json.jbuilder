json.extract! @video, :url, :key, :title, :site_id, :thumb_url
json.site_name @video.site.name

json.id @yf_video.id if @video.valid?

json.is_favorite (user_signed_in? ? current_user.liked?(@yf_video) : false)

json.auth_token form_authenticity_token
