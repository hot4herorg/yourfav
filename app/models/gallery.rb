class Gallery < ActiveRecord::Base

	belongs_to :user

	validates :user_id, presence: true

	has_many :gallery_videos, dependent: :destroy
	has_many :videos, through: :gallery_videos

	default_scope { order(created_at: :desc) }

	def videos_of_gallery
		gallery_videos.map(&:video)
	end

end
