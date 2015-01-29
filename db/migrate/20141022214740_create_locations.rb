class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :image
      t.string :street_address
      t.string :street_address2
      t.string :city_town
      t.string :state_parish
      t.string :zipcode
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :locations, [:id, :longitude, :latitude]
  end
end
