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

  it "is only returning upcoming events" do
    Event.create(event_attributes)
    expect(Event.count).to eq(1)
    Event.upcoming.first.starts_at >= Time.now
  end

  it "does not show events in the past" do
    event = Event.create(event_attributes(starts_at: 1.month.ago))

    expect(Event.upcoming).not_to include(event)
  end

  it "is only returning events in the future" do
    event = Event.create(event_attributes)

    expect(Event.upcoming).to include(event)
  end

  it "is ordered by the nearest starts at date" do
    event1 = Event.create(event_attributes(starts_at: 1.month.from_now))
    event2 = Event.create(event_attributes(starts_at: 2.month.from_now))
    event3 = Event.create(event_attributes(starts_at: 3.month.from_now))

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

