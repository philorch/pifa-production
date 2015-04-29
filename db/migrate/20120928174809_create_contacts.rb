class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :address1
      t.string :address2
      t.string :city
      t.integer :zip
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end
