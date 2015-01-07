class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :date, :date
    add_column :events, :time, :time
    add_column :events, :occurrence, :string
    add_column :events, :description, :text
    add_column :events, :adm, :decimal, precision: 8, scale: 2
    add_index :events, [:id, :date]
    add_index :events, :date
  end
end
