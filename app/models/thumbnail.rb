class Thumbnail <ActiveRecord::Base

	belongs_to :video

	validates :url, uniqueness: { scope: :video_id }

end
