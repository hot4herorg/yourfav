class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :domain
      t.string :embed_code
      t.string :login_address
      t.string :login_method
      t.boolean :ph_network
      t.boolean :enabled

      t.timestamps null: false
    end
  end
end
