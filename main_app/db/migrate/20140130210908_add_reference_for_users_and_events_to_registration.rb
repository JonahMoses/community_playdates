class AddReferenceForUsersAndEventsToRegistration < ActiveRecord::Migration
  def change
    add_reference :registrations, :user, index: true
    add_reference :registrations, :event, index: true
    add_reference :registrations, :role, index: true
  end
end
