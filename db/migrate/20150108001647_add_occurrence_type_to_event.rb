class AddOccurrenceTypeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :occurrence_type, :string
  end
end
