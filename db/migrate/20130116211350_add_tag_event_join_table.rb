class AddTagEventJoinTable < ActiveRecord::Migration
  def change
    create_table :events_tags, :id => false do |t|
      t.integer :tag_id
      t.integer :event_id
    end
  end
end
