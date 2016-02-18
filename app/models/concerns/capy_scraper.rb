

module CapyScraper
	extend ActiveSupport::Concern

	included do

		require 'open-uri'

	end

	module ClassMethods
	end

	def capy_test
		# page = Capybara::Session.new(:poltergeist)

		# page.visit 'http://www.pornhub.com/view_video.php?viewkey=1916645360'

		# puts page.title
	end

end