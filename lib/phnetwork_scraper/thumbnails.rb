module PhnetworkScraper

	class Thumbnail

		attr_accessor :url

		def initialize(video)

			page = Nokogiri::HTML open(video.embed_code)
			case video.site.domain
			when 'pornhub.com', 'keezmovies.com', 'extremetube.com', 'xtube.com'
				match_var = 'image_url'
			when 'youporn.com', 'redtube.com'
				match_var = 'poster'
			when 'spankbang.com'
				match_var = 'cover_image'
			when 'xhamster.com'
				match_var = 'thumb'
			when 'spankwire.com'
				match_var = 'posterUrl'
			when 'tube8.com'
				return @url = page.css('#flvplayer video').first.attribute('poster').text
			when 'xvideos.com'
				page = Nokogiri::HTML open(video.url)
				return @url = page.css('#player > embed').to_s.match(/thumb=(.*?)*(.*?)&/)[2].gsub('\/', '/')
			when 'playvids.com'
				match_var = 'big_thumb'
				return @url = page.css('#video > embed').attribute('flashvars').text.match(/#{match_var}(.*?)((?:https?|\/\/)(.*?)(?:png|jpe?g|gif))/)[2].gsub('\/', '/')
			else
				return nil
			end

			@url = URI.decode(page.text).match(/#{match_var}(.*?)((?:https?|\/\/)(.*?)(?:png|jpe?g|gif))/)[2].gsub('\/', '/')

		# rescue
		# 	nil
		end

	end

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
