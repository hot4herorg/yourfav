module VideosHelper

	def toggle_favorite_link(video, text=true)
		link_path = user_signed_in? ? toggle_favorite_video_path(video) : new_user_session_path
		link_to fa_icon('heart', text: text ? 'Favorite' : nil), link_path, class: "toggleFavVideo#{video.id} btn btn-sm btn-#{video.is_favorited?(current_user, true)}", remote: user_signed_in?
	end

end
