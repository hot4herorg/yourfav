class Favorite < ActiveRecord::Base

	include Scraper

	attr_accessor :was_created

	default_scope { order(created_at: :desc) }
	scope :enabled, -> { where(enabled: true) }

	belongs_to :user
	belongs_to :video

	validates_uniqueness_of :video_id, scope: :user_id, message: 'is already in your favorites.'

end
