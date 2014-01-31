class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :description 
  belongs_to :location
  has_many :registrations

  def self.upcoming
    where("start_time >= ?", Time.now).order("start_time")
  end

  def attendees
    role = Role.find_by(identity: "attendee")
    reg = registrations.select {|r| r.role_id == role.id}
    users = reg.map do |r|
      r.user
    end
    users
  end

  def creator
    role = Role.find_by(identity: "creator")
    reg = registrations.select {|r| r.role_id == role.id}
    reg.first.user
  end

end
