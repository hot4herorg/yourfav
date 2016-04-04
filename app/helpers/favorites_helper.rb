module FavoritesHelper

	def favorite_star_btn(star, text=nil)
		text ||= content_tag(:i, nil, class: 'fa fa-heart')
		if user_signed_in?
			if current_user.liked? star
				link_to text, unfavorite_star_path(star), method: :delete, remote: :true, class: "btn btn-sm btn-danger btn-star-favorite-#{star.id}"
			else
				link_to text, favorite_star_path(star), method: :post, remote: :true, class: "btn btn-sm btn-default btn-star-favorite-#{star.id}"
			end
		else
			link_to text, new_user_session_path, class: "btn btn-sm btn-default btn-star-favorite-#{star.id}"
		end
	end

	def favorite_video_li(video, text=nil)
		text ||= content_tag(:i, nil, class: ['fa fa-heart', ('text-danger' unless current_user.liked? video)])
		if current_user.liked? video
			content_tag :li, link_to(text, unfavorite_video_path(video), method: :delete, remote: :true), class: 'favorite-item text-center active'
		else
			content_tag :li, link_to(text, favorite_video_path(video), method: :post, remote: :true), class: 'favorite-item text-center'
		end
	end

end
