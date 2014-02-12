class RegistrationClient

  def self.create(role_id, user_id, event_id)
    Faraday.post("#{domain}/registrations?role_id=#{role_id}&user_id=#{user_id}&event_id=#{event_id}&auth_id=#{ENV['APP_CONFIRMATION']}")
  end

  def self.event_role_registrations(role_id, event_id)
    response = Faraday.get("#{domain}/registrations/roles/#{role_id}/#{event_id}?auth_id=#{ENV['APP_CONFIRMATION']}")
    create_registrations(response.body)
  end

  def self.for_user(user_id)
    response = Faraday.get("#{domain}/registrations/users/#{user_id}?auth_id=#{ENV['APP_CONFIRMATION']}")
    create_registrations(response.body)
  end

  def self.create_registrations(input)
    JSON.parse(input).collect do |registration_params|
      Registration.new(registration_params["role_id"],
                       registration_params["user_id"],
                       registration_params["event_id"])
    end
  end

  def self.domain
    if Rails.env.production?
      return "http://communityplaydates.com:3001"
    else
      return "http://localhost:3001"
    end
  end

end
