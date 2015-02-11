class RenameListingColoumns < ActiveRecord::Migration
  def change
    rename_column :listings, :listing_day,    :listed_day
    rename_column :listings, :listing_month,  :listed_month
    rename_column :listings, :listing_type,   :listed_type
  end
end
