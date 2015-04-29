class AddBgImageToStories < ActiveRecord::Migration
  def change
    add_column :stories, :image, :string
  end
end
