class AddCreditImageToEvents < ActiveRecord::Migration
  def change
    add_column :events, :credit_image, :string
  end
end
