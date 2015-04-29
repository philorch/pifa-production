class AddHistoricYearToEvents < ActiveRecord::Migration
  def change
    add_column :events, :historic_year, :bigint
  end
end
