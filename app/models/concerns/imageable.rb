module Imageable
	extend ActiveSupport::Concern

	included do
		has_many :thumbnails, as: :imageable, dependent: :destroy
		accepts_nested_attributes_for :thumbnails, reject_if: :should_reject, allow_destroy: true

		scope :has_image, -> { joins(:thumbnails).distinct }
	end

	def should_reject(attributes)
		if attributes[:id].present?
			return false
		elsif attributes[:image].blank?
			return true
		else
			return false
		end
	end

end