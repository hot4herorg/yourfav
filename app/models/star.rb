class Star < ActiveRecord::Base

	has_many :video_stars, dependent: :destroy
	has_many :videos, through: :video_stars

	default_scope { includes :videos }

	def thumbnail
		self.videos.first.thumb
	end

end
