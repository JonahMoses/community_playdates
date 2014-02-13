class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider         = auth[:provider]
      user.uid              = auth[:uid]
      user.name             = auth[:name]
      user.email            = auth[:email]
      user.oauth_token      = auth[:oauth_token]
      user.oauth_expires_at = auth[:oauth_expires_at]
      user.save!
    end
  end

  def all_friends
    @all_friends ||= facebook.get_connection("me", "friends").collect do |friend|
      Friend.new(friend["name"], friend["id"], @facebook)
    end
  end

  def friends_on_community_playdates
    @local_friends ||= friend_data
  end

  def friend_data
    all_friend_ids = all_friends.map {|f| f.id}
    User.all.select{ |user| all_friend_ids.include?(user.uid) }
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
    self.update_attributes(large_avatar: avatar_path)
  end

  def new_friends_of_friends
    friends.collect {|f| f.friends}
  end

end
