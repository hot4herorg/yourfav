class CreateVideoStars < ActiveRecord::Migration
  def change
    create_table :video_stars do |t|
      t.belongs_to :video, index: true, foreign_key: true
      t.belongs_to :star, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
