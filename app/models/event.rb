class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :description, length: {minimum: 25}
  belongs_to :location

  def self.upcoming
    where("start_time >= ?", Time.now).order("start_time")
  end


end
