class Star < ActiveRecord::Base

	acts_as_votable

	attr_accessor :star_tokens

	has_many :video_stars, dependent: :destroy
	has_many :videos, through: :video_stars

	default_scope { includes(:videos).order(:name) }

	scope :has_videos, -> { where.not('videos.id' => nil) }

	def name
		self[:name].titleize
	end

	def thumbnail
		self.videos.first.thumb
	end

	def thumbnails
		self.videos.map(&:thumb)
	end

	def self.tokens(query)
		stars = where("name like ?", "%#{query}%")
		if stars.empty?
			[{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
		else
			stars
		end
	end

	def self.ids_from_tokens(tokens)
		tokens.gsub!(/<<<(.+?)>>>/){ self.create!(name: $1).id }
		tokens.split(',')
	end

end
