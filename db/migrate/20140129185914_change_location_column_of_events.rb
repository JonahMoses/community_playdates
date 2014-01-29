class ChangeLocationColumnOfEvents < ActiveRecord::Migration

  def up
    add_reference :events, :locations, index: true
  end

  def down
    remove_column :events, :location
  end
end
