module VideosHelper

	def toggle_favorite_link(video, options={})
		options = {size: :sm, text: true}.merge(options)
		link_path = user_signed_in? ? toggle_favorite_video_path(video) : new_user_session_path
		link_to fa_icon('heart', text: options[:text] ? 'Favorite' : nil), link_path, class: "toggleFavVideo#{video.id} btn btn-#{options[:size]} btn-#{video.is_favorited?(current_user, true)}", remote: user_signed_in?
	end

end
