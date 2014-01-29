class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :description, length: {minimum: 25}
  belongs_to :locations

  def self.upcoming
    where("starts_at >= ?", Time.now).order("starts_at")
  end


end
