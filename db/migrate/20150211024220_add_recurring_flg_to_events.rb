class AddRecurringFlgToEvents < ActiveRecord::Migration
  def change
    add_column :events, :recurring_flg, :boolean, default: false
  end
end
