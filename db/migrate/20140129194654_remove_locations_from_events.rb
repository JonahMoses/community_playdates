class RemoveLocationsFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :locations_id, :integer
  end
end
