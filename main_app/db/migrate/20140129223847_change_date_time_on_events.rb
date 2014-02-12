class ChangeDateTimeOnEvents < ActiveRecord::Migration
  def change
    remove_column :events, :starts_at, :datetime
    add_column :events, :date, :date
    add_column :events, :time, :time
  end
end
