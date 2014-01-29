class Event < ActiveRecord::Base
  validates :name, :location, presence: true

  validates :description, length: {minimum: 25}

  def self.upcoming
    where("starts_at >= ?", Time.now).order("starts_at")
  end

end
