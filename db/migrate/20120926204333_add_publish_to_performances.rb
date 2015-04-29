class AddPublishToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :publish, :integer, :default => 1
  end
end
