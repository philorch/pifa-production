class AddTessituraFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :tessitura_name, :text
    add_column :events, :tessitura_description, :text
  end
end
