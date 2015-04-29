class AddWedAddressToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :web_address, :string
  end
end
