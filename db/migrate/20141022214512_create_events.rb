class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer   :venue_id
      t.integer   :category_id
      t.string    :name
      t.string    :photo
      t.datetime  :start_dt
      t.datetime  :end_dt
      t.text      :description
      t.string    :listed_day
      t.string    :listed_month
      t.string    :listed_type
      t.decimal   :adm,           precision: 8, scale: 2
      t.timestamps
    end
    add_index :events, :venue_id, unique: true
    add_index :events, :category_id
  end
end
