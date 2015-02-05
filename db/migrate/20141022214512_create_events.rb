class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :location_id
      t.string :name
      t.string :image
      t.string :frequency
      t.string :day_of_occurrence
      t.string :month_of_occurrence

      t.timestamps
    end
    add_index :events, [:id, :location_id]
  end
end
