class AddOccurrenceDetailsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :occurrence_details, :string
  end
end
