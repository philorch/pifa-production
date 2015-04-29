class AddTicketingEndOverrideToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ticketing_end, :integer, default: 2
  end
end
