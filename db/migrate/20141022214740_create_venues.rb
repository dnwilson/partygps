class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :photo
      t.text   :description
      # t.string :street_address
      # t.string :street_address2
      # t.string :city
      # t.string :state
      # t.string :zipcode
      # t.string :country
      # t.float :latitude
      # t.float :longitude

      t.timestamps
    end
    add_index :venues, :name
    # add_index :venues, [:id, :longitude, :latitude]
  end
end
