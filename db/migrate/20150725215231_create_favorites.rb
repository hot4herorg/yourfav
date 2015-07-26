class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :video, index: true, foreign_key: true
      t.boolean :enabled
      t.integer :position

      t.timestamps null: false
    end
  end
end
