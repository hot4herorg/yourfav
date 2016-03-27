module VideosHelper

	def is_videos_show_action?
		params[:controller] == 'videos' && params[:action] == 'show' && !request.xhr?
	end

	def video_favorite_delete_path(*args)

	end

end
