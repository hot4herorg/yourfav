class AddValidStatusToThumbnails < ActiveRecord::Migration
  def change
    add_column :thumbnails, :valid_status, :boolean
  end
end
