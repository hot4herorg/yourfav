module VideosHelper

	def is_videos_show_action?
		params[:controller] == 'videos' && params[:action] == 'show' && !request.xhr?
	end

end
