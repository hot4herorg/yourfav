class User < ActiveRecord::Base

	include DeviseAuth

	has_many :favorites
	has_many :videos, through: :favorites

end
