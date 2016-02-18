class CreateGalleryVideos < ActiveRecord::Migration
  def change
    create_table :gallery_videos do |t|
      t.belongs_to :gallery, index: true, foreign_key: true
      t.belongs_to :video, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
