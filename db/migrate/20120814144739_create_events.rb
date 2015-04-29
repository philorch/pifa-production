class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :performer
      t.text :description
      t.text :artistic_credit
      t.date :historic_date
      t.string :historic_description

      t.timestamps
    end
  end
end
