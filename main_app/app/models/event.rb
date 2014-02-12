class Event < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :location

  def self.upcoming
    where("start_time >= ?", Time.now).order("start_time")
  end

  def self.sorted_by_day(user)
    events = user.events.each_with_object({}) do |event, hash|
      if hash[event.date]
        hash[event.date] << event
      else
        hash[event.date] = [event]
      end
    end
    h = {}
    events.each do |key, value|
      h[key] = value.sort_by { |e| e.start_time }
    end
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
