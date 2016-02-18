module FavoritesHelper

	def favorite_btn(video, text='<3')
		if user_signed_in?
			if video.marked_as? :favorite, by: current_user
				link_to text, video_favorite_delete_path(video), method: :delete, remote: :true, class: "btn btn-sm btn-danger btn-video-favorite-#{video.id}"
			else
				link_to text, video_favorite_path(video), method: :post, remote: :true, class: "btn btn-sm btn-default btn-video-favorite-#{video.id}"
			end
		else
			link_to text, sites_path, class: "btn btn-sm btn-default btn-video-favorite-#{video.id}"
		end
	end

end
