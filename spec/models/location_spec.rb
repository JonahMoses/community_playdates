require 'spec_helper'

describe Location do

  it "is valid" do
    expect(Location.create(location_attributes)).to be_valid
  end

  it "requires presence of a venue" do
    location = Location.create(location_attributes(venue: nil))
    expect(location).to validate_presence_of :venue
    location.should have(1).errors_on(:venue)
  end

  it "requires presence of a street address" do
    location = Location.create(location_attributes(street_address: nil))
    expect(location).to validate_presence_of :street_address
    location.should have(1).errors_on(:street_address)
  end

  it "requires presence of city" do
    location = Location.create(location_attributes(city: nil))
    expect(location).to validate_presence_of :city
    location.should have(1).errors_on(:city)
  end

  it "requires presence of state" do
    location = Location.create(location_attributes(state: nil))
    expect(location).to validate_presence_of :state
    location.should have(1).errors_on(:state)
  end

  it "requires presence of zipcode" do
    location = Location.create(location_attributes(zipcode: nil))
    expect(location).to validate_presence_of :zipcode
    location.should have(1).errors_on(:zipcode)
  end

end
