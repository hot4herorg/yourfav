module Scraper
	extend ActiveSupport::Concern

	included do

		require 'open-uri'

		# include CapyScraper
		# include ThumbnailScraper

		attr_accessor :scrapee_url

		validates :scrapee_url, format: URI::regexp(%w(http https)), allow_blank: true
		validate :validate_url_has_video

	end

	module ClassMethods
	end

	def save_video_from_url
		unless Video.unscoped.where(video_attributes).any?
			self.assign_attributes video_attributes(true)
		else
			errors[:base] << "Video already exists."
			false
		end
	rescue
		false
	end

	def save_video_thumb
		if thumb = get_video_thumb(scrapee_url, self.title, true)
			puts thumb
			self.thumbnails.create(remote_image_url: thumb)
		end
	end

	def save_favorite_from_url
		self.video = Video.find_or_create_by video_attributes do |new_video|
			new_video.title = get_video_title(scrapee_url)
			if thumb = get_video_thumb(scrapee_url, self.video.title, true)
				new_video.thumbnails.create(remote_image_url: thumb)
			end
		end

		self.save
	rescue
		false
	end

	private

	def scrapee_url?
		self.scrapee_url.present?
	end

	def video_attributes(include_title=false)
		video_attributes = {
			site: Site.find_or_create_by( domain: get_video_domain(scrapee_url) ),
			key: get_video_key(scrapee_url),
		}
		video_attributes[:title] = get_video_title(scrapee_url) if include_title
		video_attributes
	end

	def get_video_thumb(url, title, site)
		puts "Getting Video Thumbanil"

		if site
			page = noko_url 'http://www.pornmd.com/straight/' + title.gsub(' ', '+')

			page.search('.thumb-container a').first(10).each_with_index do |link, index|
				link_url = open("http://www.pornmd.com#{link['href'].to_s}").base_uri.to_s
				thumb = link.children.css('img').attr('data-original')
				return thumb if link_url == url
			end
			return false
		else
			return false
		end
	rescue
		return false
	end

	def get_video_domain(url)
		host = URI.parse(url).host.downcase
		domain = host.start_with?('www.') ? host[4..-1] : host
	end

	def get_video_key(url)
		case get_video_domain(url)
		when 'pornhub.com'
			# key = URI.parse(url).query.to_s.gsub('viewkey=', '')
			key = Rack::Utils.parse_query(URI(url).query)['viewkey']
		when 'tube8.com', 'redtube.com'
			key = URI.parse(url).path[1..-1]
		when 'keezmovies.com', 'youporn.com', 'extremetube.com'
			key = URI.parse(url).path[7..-1]
		when 'spankwire.com', 'xvideos.com'
			key = URI.parse(url).path.match(/video(.*)\//)[1].to_i
		when 'xhamster.com'
			key = URI.parse(url).path.match(/movies\/(.*)\//)[1].to_i
		when 'youjizz.com'
			key = URI.parse(url).path.match(/videos\/(.*)-(.*).html/)[2].to_i
		when 'spankbang.com'
			key = URI.parse(url).path.match(/\/(.*)\/(.*?\/)/)[1]
		else
			key = nil
		end
	end

	def get_video_title(url)
		page = noko_url url
		case get_video_domain(url)
		when 'pornhub.com'
			title = page.css('h1.title').first.text
		when 'tube8.com'
			title = page.css('span.fn').first.text
		when 'keezmovies.com'
			title = page.css('h1.title_video_page').first.text
		when 'youporn.com'
			title = page.css('h1.grid_9').first.text
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
			title = page.css('main#container > h1').first.text
		else
			title = nil.to_s
		end
		title = title.gsub(/[^0-9A-Za-z\s]/i, '').squish.titleize
	end

	def validate_url_has_video
		return true unless self.scrapee_url.present?
		url = self.scrapee_url
		case get_video_domain(url)
		when 'pornhub.com'
			URI.parse(url).path.include? 'view_video.php'
		when 'tube8.com'
			URI.parse(url).path.to_s =~ /\d/
		when 'keezmovies.com', 'extremetube.com', 'spankbang.com', 'spankwire.com', 'xvideos.com', 'youjizz.com'
			URI.parse(url).path.include? '/video'
		when 'youporn.com'
			URI.parse(url).path.include? '/watch/'
		when 'redtube.com'
			URI.parse(url).path[1..-1].to_i.is_a? Integer
		when 'xhamster.com'
			URI.parse(url).path.include? '/movies/'
		else
			false
		end
	end

	def noko_url(url)
		doc = Nokogiri::HTML open(url)
	end

end
