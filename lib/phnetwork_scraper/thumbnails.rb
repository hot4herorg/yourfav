require 'json'

module PhnetworkScraper
	module Thumbnails

		class << self

			def of(video)
				@site = video.site
				@url = video.thumb_url
				return get_thumb_urls
			end

			private

			def get_thumb_urls

				thumbs = []

				uri = URI.parse @url
				filename = File.basename uri.path
				path = File.path uri.path
				base = File.dirname uri.path
				ext = File.extname uri.path

				case @site.domain
				when 'pornhub.com', 'tube8.com', 'keezmovies.com', 'extremetube.com'
					16.times do |index|
						thumbs << '//' + uri.host + path.gsub(filename, "#{index+1}"+ext)
					end
				when 'xtube.com'
					15.times do |index|
						thumbs << '//' + uri.host + path.gsub(filename, "#{index+1}"+ext)
					end
				when 'spankwire.com'
					10.times do |index|
						thumbs << '//' + uri.host + path.gsub(filename, "#{index+1}"+ext)
					end
				when 'youporn.com'
					16.times do |index|
						thumbs << '//' + uri.host + base.sub(/(\d+)(?!.*\d)/){ |n| "#{index+1}/1#{ext}" }
					end
				when 'spankbang.com'
					10.times do |index|
						thumbs << '//' + uri.host + base + '/' + filename.sub(/(\d+)(?!.*\d)/){ |n| index+1 }
					end
				when 'redtube.com'
					16.times do |index|
						thumbs << '//' + uri.host + base + '/' + filename.sub(/(\d+)(?!.*\d)/){ |n| (index+1).to_s.rjust(3, '0') }
					end
				when 'xhamster.com'
					10.times do |index|
						thumbs << '//' + uri.host + base + '/' + filename.sub(/(\d+)/){ |n| index+1 }
					end
				when 'xvideos.com'
					30.times do |index|
						thumbs << '//' + uri.host + base + '/' + filename.sub(/(\d+)(?!.*\d)/){ |n| index+1 }
					end
				end

				return thumbs

			rescue
				[]
			end
		end

	end
end
