require "spec_helper"

describe "An Event" do

  it "name cannot be blank" do
    event = Event.create(event_attributes(name: nil))

    expect(event.valid?).to be_false
    expect(event.errors[:name].any?).to be_true
  end

  it "description cannot be shorter than 25 characters" do
    event = Event.create(event_attributes(description: "jadfjsdfjakjgdgs"))

    expect(event.valid?).to be_false
    expect(event.errors[:description].any?).to be_true
  end

  xit "is ordered by the nearest starts at date" do
    event1 = Event.create(event_attributes(date: 1.month.from_now))
    event2 = Event.create(event_attributes(date: 2.month.from_now))
    event3 = Event.create(event_attributes(date: 3.month.from_now))

    expect(Event.upcoming).to eq([event1, event2, event3])
  end

  xit "checks if there is a image" do
    Event.create(event_attributes(image_file_name: nil))

    expect(event.image_blank?).to eq(true)
  end

  xit "has a default value for spots" do
    Event.create(event_attributes)

    expect(Event.first.capacity).to eq(1)
  end
end

