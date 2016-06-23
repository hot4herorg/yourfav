class AddGfyToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :gfy, :string
  end
end
