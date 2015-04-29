class AddTextColorToStories < ActiveRecord::Migration
  def change
    add_column :stories, :text_color, :integer
  end
end
