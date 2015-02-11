class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer   :location_id
      t.string    :name
      t.string    :photo
      t.datetime  :start_dt
      t.datetime  :end_dt
      t.text      :description
      t.decimal   :adm,           precision: 8, scale: 2
      t.integer   :listing_id

      t.timestamps
    end
    add_index :events, [:id, :location_id], unique: true
    add_index :events, [:id, :listing_id]
  end
end
