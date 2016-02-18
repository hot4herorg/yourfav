module VideosHelper

	def toggle_favorite_link_path(video)
		user_signed_in? ? toggle_favorite_video_path(video) : new_user_session_path
	end

	def toggle_favorite_link(video, options={})
		options = {size: :sm, text: true}.merge(options)
		link_to(
			fa_icon('heart', text: options[:text] ? 'Favorite' : nil),
			toggle_favorite_link_path(video),
			remote: user_signed_in?,
			class: "toggle-fav-video toggle-fav-video-btn toggle-fav-video-#{video.id} btn btn-#{options[:size]} btn-#{video.is_favorited?(current_user, true)}"
				)
	end

end
