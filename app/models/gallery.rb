class Gallery < ActiveRecord::Base

  belongs_to :user

  has_many :gallery_videos, dependent: :destroy
  has_many :videos, -> { uniq }, through: :gallery_videos

  # validates :gallery_videos_count, numericality: { less_than_or_equal_to: 12 }
  validates_associated :gallery_videos

  accepts_nested_attributes_for :gallery_videos, allow_destroy: true, reject_if: :all_blank

end
