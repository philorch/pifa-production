class AddAddressToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :address, :string
    add_column :performances, :zip, :integer
  end
end
