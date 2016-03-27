class RemoveMarksTable < ActiveRecord::Migration
  def change
	  drop_table :marks
  end
end
