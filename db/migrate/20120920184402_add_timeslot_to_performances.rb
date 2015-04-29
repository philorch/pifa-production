class AddTimeslotToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :timeslot, :string
  end
end
