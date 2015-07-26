class ChangeVideosKeyToInteger < ActiveRecord::Migration
  def change
  	change_column :videos, :key, :string
  end
end
