class AddPositionToGalleryVideos < ActiveRecord::Migration
  def change
    add_column :gallery_videos, :position, :integer
  end
end
