class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :role

  def is_enlisted?(reg)
    (reg.user_id == user_id) && role.identity == 'attendee'
  end
end
