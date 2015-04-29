class AddTicketOverrideToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ticket_override, :text
  end
end
