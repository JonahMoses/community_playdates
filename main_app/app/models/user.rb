class User

  attr_reader :id,
    :email,
    :provider,
    :uid,
    :name,
    :oauth_token,
    :oauth_expires_at,
    :avatar,
    :large_avatar,
    :created_at

  def initialize(auth)
    @provider         = auth["provider"]
    @uid              = auth["uid"]
    @name             = auth["name"]
    @email            = auth["email"]
    @oauth_token      = auth["oauth_token"]
    @oauth_expires_at = auth["oauth_expires_at"]
    @id               = auth["id"]
    @avatar           = auth["avatar"]
    @large_avatar     = auth["large_avatar"]
    @created_at       = Time.parse(auth["created_at"])
  end

  def registrations
    RegistrationClient.for_user(id)
  end

  def events
    registrations.map(&:event).flatten
  end

  def created_events
    events.select { |event| event.creator.include? self}
  end

  def attending_events
    events.select { |event| event.attendees.include? self}
  end

  def friends
    UserClient.get_friends(id)
  end
end
