class CreateUserAddresses < ActiveRecord::Migration
  def change
    create_table :user_addresses do |t|
      t.integer :user_id
      t.string :street_address
      t.string :street_address2
      t.string :city_town
      t.string :state_parish
      t.string :zipcode
      t.string :country
      t.boolean :primary_flg

      t.timestamps
    end
  end
end