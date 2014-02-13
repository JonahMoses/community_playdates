class AddIndicesToRegistrations < ActiveRecord::Migration
  def change
    add_index :registrations, :user_id
    add_index :registrations, :role_id
    add_index :registrations, :event_id
  end
end
