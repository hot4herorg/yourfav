class GalleryVideo < ActiveRecord::Base

	belongs_to :gallery
	belongs_to :video
	validates :video_id , uniqueness: { scope: :gallery_id }

end
