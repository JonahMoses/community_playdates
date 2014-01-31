class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :role

  def is_enlisted?
    !user_id.nil? && role.identity == 'attendee'
  end
end
