class Video < ActiveRecord::Base

	belongs_to :site
	has_many :favorites, dependent: :destroy
	has_many :users, through: :favorites

	default_scope {
		includes(:favorites)
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
		case self.site.domain
		when 'pornhub.com', 'youporn.com', 'keezmovies.com', 'tube8.com', 'extremetube.com'
			"http://www.#{site.domain}/embed/#{key}"
		when 'xvideos.com'
			"http://flashservice.xvideos.com/embedframe/#{key}"
		when 'redtube.com'
			"http://embed.redtube.com/?id=#{key}"
		when 'spankbang.com'
			"http://spankbang.com/#{key}/embed/"
		when 'xtube.com'
			"http://www.xtube.com/watch.php?v=#{key}"
		when 'youjizz.com'
			"http://www.youjizz.com/videos/embed/#{key}"
		when 'xhamster.com'
			"http://xhamster.com/xembed.php?video=#{key}"
		when 'spankwire.com'
			"http://www.spankwire.com/EmbedPlayer.aspx?ArticleId=#{key}"
		else
			'/video-not-found'
		end
	end

end
