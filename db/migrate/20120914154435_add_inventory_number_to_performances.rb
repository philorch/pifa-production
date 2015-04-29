class AddInventoryNumberToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :inventory_number, :integer
  end
end
