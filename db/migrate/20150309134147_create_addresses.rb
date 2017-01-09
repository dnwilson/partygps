class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :street_address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.boolean :primary_flg
      t.integer :addressable_id
      t.string :addressable_type
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :addresses, [:id, :addressable_id]
    add_index :addresses, [:id, :longitude, :latitude]
    add_index :addresses, :addressable_id
    add_index :addresses, :addressable_type
  end
end
