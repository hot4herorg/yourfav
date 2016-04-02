class Star < ActiveRecord::Base

	acts_as_votable

	has_many :video_stars, dependent: :destroy
	has_many :videos, through: :video_stars

	default_scope { includes(:videos).order(:name) }

	def thumbnail
		self.videos.first.thumb
	end

	def thumbnails
		self.videos.map(&:thumb)
	end

end
