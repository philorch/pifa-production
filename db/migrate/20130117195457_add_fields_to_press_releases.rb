class AddFieldsToPressReleases < ActiveRecord::Migration
  def change
    add_column :press_releases, :title, :text
    add_column :press_releases, :contents, :text
    add_column :press_releases, :publish_date, :datetime
    add_column :press_releases, :release_date, :datetime
  end
end
