class StaticPagesController < ApplicationController

	before_action :authenticate_admin!, only: [:test]

	def home
	end

	def dontate
	end

	def browser_extension
	end

	def test
		tests = []
		urls = []

		# urls << 'http://www.pornhub.com/view_video.php?viewkey=1251583109'
		# urls << 'http://www.keezmovies.com/video/blonde-teen-pornstar-ride-babe-doggy-small-tits-hd-1080p-7935781'
		# urls << 'http://www.extremetube.com/video/fetishnetwork-renee-roulette-bondage-sex-on-couch-12658461'
		# urls << 'http://www.youporn.com/watch/629938/brunette-masturbates-in-bedroom/'
		# urls << 'http://spankbang.com/3uji/video/julia+roca+fucks+yoga+instructor'
		# urls << 'http://www.redtube.com/338814'
		# urls << 'http://xhamster.com/movies/4754837/nubilefilms_the_taste_of_passionate_fuck.html'
		# urls << 'http://www.xtube.com/watch.php?v=Wdnhm-S689-'
		# urls << 'http://www.spankwire.com/TUSHY-Personal-Assistant-Janice-Griffith-Loves-Anal/video2582271/'
		urls << 'http://www.tube8.com/teen/moms-teach-sex/28339511/'
		# urls << 'http://www.xvideos.com/video2541006/jessica_jaymes_-_milf_memoirs'
		urls << 'https://www.playvids.com/v/NgHwmAFNuFi'

		urls.each do |url|
			tests << PhnetworkScraper::Video.new(url)
		end

		# @video = PhnetworkScraper::Video.new urls[1]
		# render text: @video.to_json

		# page = Nokogiri::HTML open('http://www.tube8.com/embed/teen/moms-teach-sex/28339511/')
		# url = page.css('#flvplayer video').first.attribute('poster').text
		# render text: url

		render text: tests.map(&:to_json)
	end

end
