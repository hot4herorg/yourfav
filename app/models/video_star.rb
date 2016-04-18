class VideoStar < ActiveRecord::Base

	belongs_to :video
	belongs_to :star

	# extend StarTokens
	attr_accessor :star_tokens
	def star_tokens=(ids)
		self.star_ids = Star.ids_from_tokens(ids)
	end

	attr_accessor :star_name

end
