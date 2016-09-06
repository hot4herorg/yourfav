class Video < ActiveRecord::Base

	acts_as_votable

	# extend StarTokens
	attr_accessor :star_tokens
	def star_tokens=(ids)
		self.star_ids = Star.ids_from_tokens(ids)
	end

	attr_accessor :add_by_url
	before_validation :create_by_url

	validates :url, :key, :site, :thumb_url, presence: true

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

	scope :with_gfy, -> (bool=false) { where("gfy <> ''") if bool }
	scope :of_stars, -> (stars) { joins(:stars).where('stars.id' => stars.ids.uniq).uniq }

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
		# self.thumbnails.destroy_all if x?
		if self.thumb_url.present?
			PhnetworkScraper::Thumbnails.of(self).each do |url|
				self.thumbnails.find_or_create_by(url: url)
			end
		end
	end

	private

	def create_by_url
		self.assign_attributes PhnetworkScraper::Video.new(url).to_params_hash if add_by_url
	end

end
