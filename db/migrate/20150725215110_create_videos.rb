class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.integer :key
      t.belongs_to :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
