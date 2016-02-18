# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# name domain embed_code ph_network:boolean enabled:boolean
sites_array = []
# sites_array << {name: '', domain: '', embed_code: '', ph_network: false}
sites_array << {name: 'PornHub', domain: 'pornhub.com', embed_code: 'http://www.pornhub.com/embed/{{key}}', ph_network: true}
sites_array << {name: 'YouPorn', domain: 'youporn.com', embed_code: 'http://www.pornhub.com/embed/{{key}}', ph_network: true}
sites = Site.create sites_array

# url key title site:belongs_to
# http://www.pornhub.com/view_video.php?viewkey=ph56902fde4706c
# http://www.pornhub.com/view_video.php?viewkey=ph568998257ef45
# videos = Video.create()
