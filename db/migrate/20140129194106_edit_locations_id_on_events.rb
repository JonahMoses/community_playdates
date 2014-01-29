class EditLocationsIdOnEvents < ActiveRecord::Migration

  def up
    add_reference :events, :location, index: true
  end

  def down
    remove_reference :events, :locations, index: true
  end
end
