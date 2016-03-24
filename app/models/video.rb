class Video < ActiveRecord::Base

	markable_as :favorite

	validates :key, uniqueness: { scope: :site_id }

	belongs_to :site

	has_many :gallery_videos, dependent: :destroy
	has_many :galleries, through: :gallery_videos

	has_many :thumbnails, dependent: :destroy
	after_create :gen_thumbs

	default_scope { includes(:site, :thumbnails).order(created_at: :desc) }

	def embed_code
		self.site.embed_code.gsub("{{key}}", self.key)
	end

	def thumb
		if thumb_url.present? && thumbnails.any?
			thumbnails.map{ |t| File.basename(t.url) }.include?(File.basename(thumb_url)) ? thumb_url : thumbnails.first.url
		end
	end

	def enabled?
		self.site.enabled
	end

	private

	def gen_thumbs
		if self.thumb_url.present?
			PhnetworkScraper::Thumbnails.of(self.site, self.thumb_url).each do |url|
				self.thumbnails.find_or_create_by(url: url)
			end
		end
	end

	# def embed_code_old
	# 	case self.site.domain
	# 	when 'pornhub.com', 'youporn.com', 'keezmovies.com', 'tube8.com', 'extremetube.com'
	# 		"http://#{site.domain}/embed/#{key}"
	# 	when 'youjizz.com', 'jizzhut.com'
	# 		"http://#{site.domain}/videos/embed/#{key}"
	# 	when 'xvideos.com'
	# 		"http://flashservice.#{site.domain}/embedframe/#{key}"
	# 	when 'redtube.com'
	# 		"http://embed.#{site.domain}/?id=#{key}"
	# 	when 'spankbang.com'
	# 		"http://#{site.domain}/#{key}/embed/"
	# 	when 'xtube.com'
	# 		"http://www.xtube.com/watch.php?v={{key}}"
	# 	when 'xhamster.com'
	# 		"http://#{site.domain}/xembed.php?video=#{key}"
	# 	when 'spankwire.com'
	# 		"http://www.#{site.domain}/EmbedPlayer.aspx?ArticleId=#{key}"
	# 	else
	# 		'/video-not-found'
	# 	end
	# end

end
