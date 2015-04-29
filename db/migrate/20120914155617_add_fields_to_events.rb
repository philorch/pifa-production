class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :kind, :string
    add_column :events, :title, :string
    add_column :events, :begin_date, :datetime
    add_column :events, :end_date, :datetime
  end
end
