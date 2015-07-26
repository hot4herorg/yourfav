module VideosHelper

	def toggle_favorite_link(video, text=true)
		link_to fa_icon('heart', text: text ? 'Favorite' : nil), toggle_favorite_video_path(video), class: "toggleFavVideo#{video.id} btn btn-sm btn-#{video.is_favorited?(current_user, true)}", remote: true
	end

end
