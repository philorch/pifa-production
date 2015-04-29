class AddInventoryNumberToEvents < ActiveRecord::Migration
  def change
    add_column :events, :inventory_number, :integer
  end
end
