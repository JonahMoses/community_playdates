class RegistrationClient

  def self.create(role_id, user_id, event_id)
    Faraday.post("http://localhost:3001/registrations?role_id=#{role_id}&user_id=#{user_id}&event_id=#{event_id}")
  end

  def self.event_role_registrations(role_id, event_id)
    response = Faraday.get("http://localhost:3001/registrations/roles/#{role_id}?event_id=#{event_id}")
    create_registrations(response.body)
  end

  def self.for_user(user_id)
    response = Faraday.get("http://localhost:3001/registrations/users/#{user_id}")
    create_registrations(response.body)
  end

  def self.create_registrations(input)
    JSON.parse(input).collect do |registration_params|
      Registration.new(registration_params["role_id"],
                       registration_params["user_id"],
                       registration_params["event_id"])
    end
  end

end
