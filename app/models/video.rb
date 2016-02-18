class Video < ActiveRecord::Base

	include Scraper
	include Imageable

	belongs_to :site
	has_many :favorites, dependent: :destroy
	has_many :users, through: :favorites

	validates :title, :key, :site_id, presence: true, unless: :scrapee_url?

	before_save :save_video_from_url, if: :scrapee_url?
	after_create :save_video_thumb, if: :scrapee_url?

	default_scope {
		includes(:favorites, :site)
		.joins("LEFT OUTER JOIN favorites ON videos.id = favorites.video_id")
		.select("videos.*, SUM(CASE WHEN favorites.enabled = 't' THEN 1 ELSE 0 END) AS enabled_favorites_count")
		.group("videos.id")
		.order("enabled_favorites_count desc, videos.created_at desc")
	}

	def is_favorited?(user, return_btn_class=false)
		fav = self.favorites.find_by(user: user)
		btn_class = fav.try(:enabled) ? 'danger' : 'default'
		return_btn_class ? btn_class : fav.try(:enabled)
	end

	def toggle_favorite(user)
		if user
			fav = Favorite.find_or_create_by(video: self, user: user) do |f|
				f.was_created = true
			end
			fav.update_column( :enabled, !self.is_favorited?(user) ) unless fav.was_created
		else
			false
		end
	end

	def embed_code

		'http://www.jizzhut.com/videos/embed/22935491'

		case self.site.domain
		when 'pornhub.com', 'youporn.com', 'keezmovies.com', 'tube8.com', 'extremetube.com'
			"http://#{site.domain}/embed/#{key}"
		when 'youjizz.com', 'jizzhut.com'
			"http://#{site.domain}/videos/embed/#{key}"
		when 'xvideos.com'
			"http://flashservice.#{site.domain}/embedframe/#{key}"
		when 'redtube.com'
			"http://embed.#{site.domain}/?id=#{key}"
		when 'spankbang.com'
			"http://#{site.domain}/#{key}/embed/"
		when 'xtube.com'
			"http://www.#{site.domain}/watch.php?v=#{key}"
		when 'xhamster.com'
			"http://#{site.domain}/xembed.php?video=#{key}"
		when 'spankwire.com'
			"http://www.#{site.domain}/EmbedPlayer.aspx?ArticleId=#{key}"
		else
			'/video-not-found'
		end
		# 'https://www.youtube.com/embed/oeeLAIhNe0I'
	end

end
