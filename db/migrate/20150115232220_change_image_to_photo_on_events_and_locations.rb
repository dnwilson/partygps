class ChangeImageToPhotoOnEventsAndLocations < ActiveRecord::Migration
  def change
  	rename_column :events, :image, :photo 
  	rename_column :locations, :image, :photo
  	rename_column :users, :avatar, :photo
  end
end
