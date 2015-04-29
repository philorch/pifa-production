class AddFieldsToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :performance_date, :datetime
    add_column :performances, :min_price, :integer
    add_column :performances, :max_price, :integer
    add_column :performances, :buy_url, :string
    add_column :performances, :price_range, :string
    add_column :performances, :end_date, :datetime
    add_column :performances, :hide_buy_link, :integer
    add_column :performances, :world_premiere, :integer
    add_column :performances, :sold_out, :integer
    add_column :performances, :hide_event, :integer
  end
end
