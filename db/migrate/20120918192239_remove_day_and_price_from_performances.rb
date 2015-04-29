class RemoveDayAndPriceFromPerformances < ActiveRecord::Migration
  def up
    remove_column :performances, :day
    remove_column :performances, :price
  end

  def down
    add_column :performances, :price, :integer
    add_column :performances, :day, :datetime
  end
end
