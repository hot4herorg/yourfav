class Video < ActiveRecord::Base

	acts_as_votable

	belongs_to :site
	validates :key, uniqueness: { scope: :site_id }

	has_many :gallery_videos, dependent: :destroy
	has_many :galleries, through: :gallery_videos

	has_many :thumbnails, dependent: :destroy
	after_create :gen_thumbs

	has_many :video_stars, dependent: :destroy
	has_many :stars, -> { uniq }, through: :video_stars
	accepts_nested_attributes_for :video_stars, allow_destroy: true, reject_if: :all_blank

	default_scope { includes(:site, :thumbnails).order(created_at: :desc) }

	def embed_code
		self.site.embed_code.gsub("{{key}}", self.key)
	end

	def thumb
		if thumb_url.present? && thumbnails.any?
			thumbnails.map{ |t| File.basename(t.url) }.include?(File.basename(thumb_url)) ? thumb_url : thumbnails.first.url
		elsif thumb_url.present?
			thumb_url
		end
	end

	def enabled?
		self.site.enabled
	end

	def gen_thumbs
		if self.thumb_url.present?
			PhnetworkScraper::Thumbnails.of(self).each do |url|
				self.thumbnails.find_or_create_by(url: url)
			end
		end
	end

	private

end
