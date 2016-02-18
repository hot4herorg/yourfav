class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :domain
      t.string :embed_code
      t.boolean :ph_network
      t.boolean :enabled, default: true

      t.timestamps null: false
    end
  end
end
