module PhnetworkScraper
	class Video

		attr_accessor :url, :site, :site_id, :key, :embed_code, :title, :thumb_url, :thumb_array
		# attr_reader :is_valid

		def initialize(url)
			@url = url
			@site = PhnetworkScraper.get_site(@url)
			if valid?
				@site_id = @site.id
				@key = get_key
				@embed_code = @site.embed_code.gsub("{{key}}", @key.to_s)
				@title = get_title
				# @thumb_url = get_thumb_url
				@thumb_url = URI.decode PhnetworkScraper::Thumbnail.new(self).url
				@thumb_array = PhnetworkScraper::Thumbnails.of self
			end
		end

		def valid?
			@site.try(:enabled) && has_video?
		rescue
			false
		end

		private

		def get_key
			case @site.domain
			when 'pornhub.com'
				# key = URI.parse(@url).query.to_s.gsub('viewkey=', '')
				key = Rack::Utils.parse_query(URI(@url).query)['viewkey']
			when 'tube8.com', 'redtube.com'
				key = URI.parse(@url).path[1..-1]
			when 'keezmovies.com', 'youporn.com', 'extremetube.com'
				key = URI.parse(@url).path[7..-1]
			when 'spankwire.com', 'xvideos.com'
				key = URI.parse(@url).path.match(/video(.*)\//)[1].to_i
			when 'xhamster.com'
				key = URI.parse(@url).path.match(/movies\/(.*)\//)[1].to_i
			when 'youjizz.com'
				key = URI.parse(@url).path.match(/videos\/(.*)-(.*).html/)[2].to_i
			when 'spankbang.com'
				key = URI.parse(@url).path.match(/\/(.*)\/(.*?\/)/)[1]
			when 'xtube.com'
				key = Rack::Utils.parse_query(URI(@url).query)['v']
			when 'playvids.com'
				key = URI.parse(@url).path[3..-1]
			else
				key = nil
			end
		end

		def get_title
			page = Nokogiri::HTML open(@url)
			case @site.domain
			when 'pornhub.com'
				title = page.css('h1.title').first.text
			when 'tube8.com'
				title = page.css('h1.main-title').first.text
			when 'keezmovies.com'
				title = page.css('h1.title_video_page').first.text
			when 'youporn.com'
				title = page.css('h1.heading2').first.text
			when 'redtube.com'
				title = page.css('h1.videoTitle').first.text
			when 'extremetube.com'
				title = page.css('h1.title-video-box').first.text
			when 'spankwire.com'
				title = page.css('div#vidTitle > h1').first.text
			when 'xhamster.com'
				title = page.css('div.head.gr > h1').first.text
			when 'youjizz.com'
				title = page.css('#video_text > h3').first.text
			when 'spankbang.com'
				title = page.css('main#container h1').first.text
			when 'xtube.com'
				title = page.css('#videoDetails .title').first.text
			when 'xvideos.com'
				title = page.css('#main > h2').first.text
			when 'playvids.com'
				title = page.css('.watchTitle').first.text
			else
				title = nil.to_s
			end
			title = title.gsub(/[^0-9A-Za-z\s]/i, '').squish.titleize
		rescue
			nil
		end

		def get_thumb_url
			page = Nokogiri::HTML open(@embed_code)
			case @site.domain
			when 'pornhub.com', 'keezmovies.com', 'extremetube.com', 'xtube.com'
				match_var = 'image_url'
			when 'youporn.com', 'redtube.com', 'tube8.com'
				match_var = 'poster'
			when 'spankbang.com'
				match_var = 'cover_image'
			when 'xhamster.com'
				match_var = 'thumb'
			when 'spankwire.com'
				match_var = 'posterUrl'
			when 'playvids.com'
				match_var = 'big_thumb'
				return URI.decode page.css('#video > embed').attribute('flashvars').text.match(/#{match_var}(.*?)((?:https?|\/\/)(.*?)(?:png|jpe?g|gif))/)[2].gsub('\/', '/')
			when 'xvideos.com'
				page = Nokogiri::HTML open(@url)
				return page.css('#player > embed').to_s.match(/thumb=(.*?)*(.*?)&/)[2].gsub('\/', '/')
			else
				return nil
			end

			URI.decode(page.text).match(/#{match_var}(.*?)((?:https?|\/\/)(.*?)(?:png|jpe?g|gif))/)[2].gsub('\/', '/')

		rescue
			nil
		end

		def has_video?
			case @site.domain
			when 'pornhub.com'
				URI.parse(@url).path.include? 'view_video.php'
			when 'tube8.com'
				URI.parse(@url).path.to_s =~ /\d/
			when 'keezmovies.com', 'extremetube.com', 'spankbang.com', 'spankwire.com', 'xvideos.com', 'youjizz.com'
				URI.parse(@url).path.include? '/video'
			when 'youporn.com'
				URI.parse(@url).path.include? '/watch/'
			when 'redtube.com'
				URI.parse(@url).path[1..-1].to_i.is_a? Integer
			when 'xhamster.com'
				URI.parse(@url).path.include? '/movies/'
			when 'xtube.com', 'playvids.com'
				true
			else
				false
			end
		end

	end
end
