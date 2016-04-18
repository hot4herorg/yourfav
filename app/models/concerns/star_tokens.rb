module StarTokens
	extend ActiveSupport::Concern

	attr_accessor :star_tokens

	def star_tokens=(ids)
		self.star_ids = Star.ids_from_tokens(ids)
	end

end
