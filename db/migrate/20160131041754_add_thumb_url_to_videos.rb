class AddThumbUrlToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :thumb_url, :string
  end
end
