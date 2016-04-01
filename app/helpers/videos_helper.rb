module VideosHelper

	def video_thumb_link_title(video)
		if video.stars.any?
			video.stars.map(&:name).join(', ')
		else
			video.title
		end
	end

end
