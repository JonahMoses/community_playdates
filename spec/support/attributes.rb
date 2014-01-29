def event_attributes(overrides = {})
  {
    name: "Playdates",
    description: "A fun evening of playing together yeah",
    starts_at: 10.days.from_now,
    location_id: 1
  }.merge(overrides)
end
