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

  def creator
    role = Role.find_by(identity: "creator")
    registrations(role.id).map(&:user)
  end

  def registrations(role_id)
    RegistrationClient.event_role_registrations(role_id, self.id)
  end

end
