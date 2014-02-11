class Event < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :location

  def self.upcoming
    where("start_time >= ?", Time.now).order("start_time")
  end

  def attendees
    role = Role.find_by(identity: "attendee")
    registrations(role.id).map(&:user)
  end

  def attendee_and_creator_count
    attendees.count + 1
  end

  def creator
    role = Role.find_by(identity: "creator")
    registrations(role.id).map(&:user)
  end

  def registrations(role_id)
    RegistrationClient.event_role_registrations(role_id, self.id)
  end

#  def friend_events
#    return [] if User.friends.empty?
#    friends_on_community_playdates.collect do |user|
#      user.events
#    end.first.sort_by{|s| s.start_time}.reverse
#  end

end
