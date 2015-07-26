class ChangeFavoriteEnabledColumnDefault < ActiveRecord::Migration
  def change
  	change_column_default :favorites, :enabled, true
  end
end
