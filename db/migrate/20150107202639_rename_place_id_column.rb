class RenamePlaceIdColumn < ActiveRecord::Migration
  def change
  	rename_column :events, :place_id, :location_id
  	add_index :events, :location_id
  end
end
