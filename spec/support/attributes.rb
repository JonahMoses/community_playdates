def event_attributes(overrides = {})
  {
    name: "Playdates",
    description: "A fun evening of playing together yeah",
    start_time: "10:00AM",
    end_time: "12:00PM",
    location_id: 1
  }.merge(overrides)
end

def location_attributes(overrides = {})
  {
    venue: "gSchool",
    street_address: "123 Fake St",
    city: "Denver",
    state: "CO",
    zipcode: "80204"
    }.merge(overrides)
end
