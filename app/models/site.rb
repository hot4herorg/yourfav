class Site < ActiveRecord::Base

	validates :embed_code, presence: true
	validates :domain, uniqueness: true

	has_many :videos

	default_scope { order(:name) }

	scope :enabled, -> { where enabled: true }

end
