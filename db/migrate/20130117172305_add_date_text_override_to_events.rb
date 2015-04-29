class AddDateTextOverrideToEvents < ActiveRecord::Migration
  def change
    add_column :events, :date_text_override, :string
  end
end
