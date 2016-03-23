# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SITES = JSON.parse File.read("#{Rails.root}/lib/assets/sites.json"), object_class: OpenStruct

SITES.each do |site|
	Site.find_or_create_by(domain: site.domain) do |new_site|
		new_site.name = site.name
		# new_site.domain = site.domain
		new_site.embed_code = site.embed_code
		new_site.ph_network = site.ph_network
		new_site.enabled = site.enabled
	end
end

# url key title site:belongs_to
# http://www.pornhub.com/view_video.php?viewkey=ph56902fde4706c
# http://www.pornhub.com/view_video.php?viewkey=ph568998257ef45
# videos = Video.create()
