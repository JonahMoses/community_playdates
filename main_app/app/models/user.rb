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
    @registrations ||= RegistrationClient.for_user(id)
  end

  def events
    registrations.map(&:event).flatten
  end

  def created_events
    role = Role.find_by(identity: "creator")
    r = registrations.select {|registration| registration.role_id == role.id && registration.user_id == self.id}
    r.map(&:event)
  end

  def attending_events
    role = Role.find_by(identity: "attendee")
    r = registrations.select {|registration| registration.role_id == role.id && registration.user_id == self.id}
    r.map(&:event)
  end

  def friends
    @friends ||= UserClient.get_friends(id)
  end

  def friends_of_friends
    @friends_of_friends ||= something_friends_of_friends
  end

  def something_friends_of_friends
    friends_of_friends = friends.map(&:friends).flatten
    friends_of_friends.reject {|friend| friend.id == id}
  end

  def get_all_friend_data
    @friend_data ||= UserClient.get_all_friend_data(id)
  end
end
