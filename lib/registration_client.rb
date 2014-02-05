class RegistrationClient

  def self.create(role_id, user_id, event_id)
    Faraday.post("http://localhost:3001/registrations?role_id=#{role_id}&user_id=#{user_id}&event_id=#{event_id}")
  end

  attr_reader :role_id, :user_id, :event_id

  def initialize(role_id, user_id, event_id)
    @role_id = role_id
    @user_id = user_id
    @event_id = event_id
  end

end
