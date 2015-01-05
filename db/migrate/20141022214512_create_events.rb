class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :place_id
      t.string :name
      t.string :image

      t.timestamps
    end
    add_index :events, [:id, :place_id]
  end
end
