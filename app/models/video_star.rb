class VideoStar < ActiveRecord::Base

	belongs_to :video
	belongs_to :star

	attr_accessor :star_name

end
