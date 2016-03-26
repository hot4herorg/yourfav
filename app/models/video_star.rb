class VideoStar < ActiveRecord::Base
	belongs_to :video
	belongs_to :star
end
