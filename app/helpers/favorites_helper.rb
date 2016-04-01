module FavoritesHelper

	def favorite_btn(video, text='<3')
		if user_signed_in?
			if current_user.liked? video
				link_to text, '#video_favorite_delete_path(video)', method: :delete, remote: :true, class: "btn btn-sm btn-danger btn-video-favorite-#{video.id}"
			else
				link_to text, '#video_favorite_path(video)', method: :post, remote: :true, class: "btn btn-sm btn-default btn-video-favorite-#{video.id}"
			end
		else
			link_to text, new_user_session_path, class: "btn btn-sm btn-default btn-video-favorite-#{video.id}"
		end
	end

	def favorite_li(video)
		if current_user.liked? video
			content_tag :li, link_to(content_tag(:i, nil, class: 'fa fa-heart'), '#'), class: 'favorite-item text-center active'
		else
			content_tag :li, link_to(content_tag(:i, nil, class: 'fa fa-heart'), '#'), class: 'favorite-item text-center'
		end
	end

end
