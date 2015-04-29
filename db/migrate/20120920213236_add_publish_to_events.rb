class AddPublishToEvents < ActiveRecord::Migration
  def change
    add_column :events, :publish, :integer, :default => 1
  end
end
