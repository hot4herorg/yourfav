class GalleryVideo < ActiveRecord::Base

	belongs_to :gallery
	belongs_to :video

end
