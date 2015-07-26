class Video < ActiveRecord::Base

	belongs_to :site
	has_many :favorites
	has_many :users, through: :favorites

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
