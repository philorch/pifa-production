class CreateSimilarEvents < ActiveRecord::Migration
  def change
    create_table :similar_events do |t|
      t.integer :similar_id
      t.integer :event_id

      t.timestamps
    end
  end
end
