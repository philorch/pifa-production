class AddShowDefaultPuchaseButtonToEvents < ActiveRecord::Migration
  def change
    add_column :events, :show_default_purchase_button, :boolean
  end
end
