class Gallery < ActiveRecord::Base

	belongs_to :user

	has_many :gallery_videos, dependent: :destroy
	has_many :videos, -> { uniq }, through: :gallery_videos

end
