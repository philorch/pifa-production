class AddPriceRangeOverrideToEvents < ActiveRecord::Migration
  def change
    add_column :events, :price_range_override, :string
  end
end
