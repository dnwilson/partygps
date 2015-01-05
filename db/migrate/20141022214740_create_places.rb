class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :image
      t.string :street_address
      t.string :city_town
      t.string :state_parish
      t.string :zipcode
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :places, [:id, :longitude, :latitude]
    add_index :places, [:longitude, :latitude], unique: true
  end
end
