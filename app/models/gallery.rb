class Gallery < ActiveRecord::Base

	belongs_to :user

	validates :user_id, presence: true

	has_many :gallery_videos, dependent: :destroy
	has_many :videos, -> { uniq }, through: :gallery_videos

end
