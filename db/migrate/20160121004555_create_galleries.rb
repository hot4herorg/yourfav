class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.belongs_to :user, index: true, foreign_key: true
      t.boolean :private

      t.timestamps null: false
    end
  end
end
