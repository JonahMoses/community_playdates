def event_attributes(overrides = {})
  {
    name: "Playdates",
    location: "Denver",
    description: "A fun evening of playing together yeah",
    starts_at: 10.days.from_now,
  }.merge(overrides)
end
