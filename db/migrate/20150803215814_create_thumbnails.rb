class CreateThumbnails < ActiveRecord::Migration
  def change
    create_table :thumbnails do |t|
      t.string :title
      t.text :caption
      t.string :alt
      t.references :imageable, polymorphic: true, index: true
      t.string :image

      t.timestamps null: false
    end
  end
end
