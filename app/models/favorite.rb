class Favorite < ActiveRecord::Base

	include Scraper

	default_scope { order(created_at: :desc) }

	belongs_to :user
	belongs_to :video

	validates_uniqueness_of :video_id, scope: :user_id, message: 'is already in your favorites.'
	
end
