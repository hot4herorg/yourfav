# require 'rubygems'
# require 'nokogiri'
# require 'capybara'
# require 'capybara/poltergeist'
# require 'phantomjs'

# Capybara.register_driver :poltergeist do |app|

# 	options = {
# 		phantomjs: Phantomjs.path,
# 		js_errors: false
# 	}

# 	Capybara::Poltergeist::Driver.new(app, options)
# end

# namespace :capy do

# 	task test: :environment do
# 		puts 'test succeeded'
# 	end

# 	task scrape: :environment do
# 		page = Capybara::Session.new(:poltergeist)

# 		page.visit 'http://www.pornhub.com/view_video.php?viewkey=1916645360'

# 		puts page.title
# 	end
	
# end