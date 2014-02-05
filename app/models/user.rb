class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :rememberable, :trackable
  has_many :registrations

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider         = auth.provider
      user.uid              = auth.uid
      user.name             = auth.info.name
      user.email            = auth.info.email
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def all_friends
    @friend_data = facebook.get_connection("me", "friends")
    @friend_data.collect do |friend|
      Friend.new(friend["name"], friend["id"], @facebook)
    end
  end

  def friends_on_community_playdates
    all_friend_ids = all_friends.map {|f| f.id}
    User.all.select{ |user| all_friend_ids.include?(user.uid) }
  end

  def friend_events
    return [] if friends_on_community_playdates.empty?
    friends_on_community_playdates.collect do |user|
      user.events
    end.first.sort_by{|s| s.start_time}.reverse
  end

  def friends_of_friends
    people = friends_on_community_playdates.collect do |friend|
      friend.friends_on_community_playdates
    end.flatten
    people.reject {|p| p == self}
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def find_avatar
    avatar_path = facebook.get_picture( uid, type: 'square' )
    self.update_attributes( avatar: avatar_path )
  end

  def find_large_avatar
    avatar_path = facebook.get_picture( uid, :type => 'large')
  end

  def current_registrations
    registrations.select {|r| r.event.start_time <= Time.current }
  end

  def all_events
    registrations.map(&:event)
  end

  def events
    current_registrations.map(&:event)
  end

  def created_events
    role = Role.find_by(identity: 'creator')
    current_registrations.select { |r| r.role == role}.map(&:event)
  end

  def attending_events
    role = Role.find_by(identity: 'attendee')
    current_registrations.select { |r| r.role == role}.map(&:event)
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end
