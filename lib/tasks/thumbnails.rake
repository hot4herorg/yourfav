require 'nokogiri'
require 'open-uri'

namespace :thumbs do

	# rake thumbs:test
	task test: :environment do
		page = Nokogiri::HTML open('http://www.xvideos.com/video520534/blonde_teen_kendall_fucks_for_a_job')
		puts page.xpath("//meta[@property='og:image']/@content").first
	end


end
