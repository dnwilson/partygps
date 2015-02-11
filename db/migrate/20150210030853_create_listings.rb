class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.belongs_to  :category
      t.belongs_to  :event
      t.string      :listing_day
      t.string      :listing_month
      t.string      :listing_type

      t.timestamps
    end
  end
end
