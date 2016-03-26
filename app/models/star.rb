class Star < ActiveRecord::Base

	has_many :video_stars, dependent: :destroy

end
