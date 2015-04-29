class AddEventIdToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :event_id, :integer
  end
end
