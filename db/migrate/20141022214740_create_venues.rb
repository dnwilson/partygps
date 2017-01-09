class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :image
      t.string :photo

      t.timestamps
    end
    add_index :venues, :name
  end
end
