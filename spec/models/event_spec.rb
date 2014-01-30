require "spec_helper"

describe "An Event" do

  it "name cannot be blank" do
    event = FactoryGirl.build(:event, name: nil)

    expect(event.valid?).to be_false
    expect(event.errors[:name].any?).to be_true
  end

  it "description cannot be shorter than 25 characters" do
    event = FactoryGirl.build(:event, description: 'fun' * 5)

    expect(event.valid?).to be_false
    expect(event.errors[:description].any?).to be_true
  end

  xit "has a default value for spots" do
    Event.create(event_attributes)

    expect(Event.first.capacity).to eq(1)
  end
end

