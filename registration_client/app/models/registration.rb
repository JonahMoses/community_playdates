class Registration < ActiveRecord::Base

  def self.by_event_role(role, event)
    where(role_id: role, event_id: event)
  end

  def self.for_user(id)
    where(user_id: id)
    # when events are broken out, call from here
  end

  def self.delete(event, user)
    reg = Registration.find_by(event_id: event, user_id: user)
    Registration.destroy(reg.id)
  end
end
