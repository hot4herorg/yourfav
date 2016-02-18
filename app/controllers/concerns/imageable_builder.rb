module ImageableBuilder
	extend ActiveSupport::Concern

	included do
	end

	def image_params
		[:id, :image, :title, :caption, :alt, :imageable_id, :imageable_type, :_destroy]
	end

end