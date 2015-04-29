class AddSecondaryImageToEvents < ActiveRecord::Migration
  def change
    add_column :events, :image2, :string
  end
end
