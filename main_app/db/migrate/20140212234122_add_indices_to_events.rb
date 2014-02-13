class AddIndicesToEvents < ActiveRecord::Migration
  def change
    add_index :events, :date
    add_index :events, :start_time
  end
end
