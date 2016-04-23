class GalleryVideo < ActiveRecord::Base

	belongs_to :gallery
	belongs_to :video

	validates :gallery, :video, presence: true

	validates :video, uniqueness: { scope: :gallery, message: "can appear once in a gallery" }

	default_scope { order(position: :asc, created_at: :desc) }

end
