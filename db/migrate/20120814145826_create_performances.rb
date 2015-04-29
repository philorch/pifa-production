class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.datetime :day
      t.integer :price
      t.string :location

      t.timestamps
    end
  end
end
