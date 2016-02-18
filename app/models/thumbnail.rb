class Thumbnail < ActiveRecord::Base

	mount_uploader :image, ImageUploader

	belongs_to :imageable, polymorphic: true

	# default_scope { order(position: :asc, created_at: :asc) }
	default_scope { order(created_at: :asc) }
	
end
