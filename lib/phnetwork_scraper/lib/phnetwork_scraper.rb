require 'phnetwork_scraper/version'
require 'phnetwork_scraper/video'
require 'phnetwork_scraper/thumbnails'

require 'open-uri'

module PhnetworkScraper
	class Engine < ::Rails::Engine; end;

	def self.get_site(url)
		host = URI.parse(url).host.downcase
		domain = host.start_with?('www.') ? host[4..-1] : host
		site = Site.find_by(domain: domain)
	rescue
		nil
	end

end
