class Location < ActiveRecord::Base
  validates :venue, :street_address,
            :city, :state, :zipcode, presence: true
  has_many :events
end
