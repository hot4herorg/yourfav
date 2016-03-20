class Video < ActiveRecord::Base

	markable_as :favorite

	validates :key, uniqueness: { scope: :site_id }

	belongs_to :site

	has_many :gallery_videos, dependent: :destroy
	has_many :galleries, through: :gallery_videos

	default_scope { includes(:site).order(created_at: :desc) }

	def embed_code
		self.site.embed_code.gsub("{{key}}", self.key)
	end

	def thumbnail
		self.thumb_url if self.thumb_url.present?
	end

	def thumbnails_data
		PhnetworkScraper::Thumbnails.of self.site, self.thumb_url if self.thumb_url.present?
	end

	def enabled?
		self.site.enabled
	end

	private

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
