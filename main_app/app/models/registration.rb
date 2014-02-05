class Registration

  attr_reader :role_id, :user_id, :event_id

  def initialize(role_id, user_id, event_id)
    @role_id = role_id
    @user_id = user_id
    @event_id = event_id
  end

  def is_enlisted?(reg)
    (reg.user_id == user_id) && role.identity == 'attendee'
  end

  def event
    Event.all.select {|event| event.id == event_id}.first
  end

  def user
    User.all.select { |user| user.id == user_id }.first
  end
end
