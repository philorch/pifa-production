class AddLocationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :location, :string
    add_column :events, :address, :string
    add_column :events, :zip, :string
  end
end
