# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  Role.create([{ identity: 'attendee' },
                { identity: 'creator'}])

  # role = Role.last

  # location = Location.create({
  #                     venue: "The Shire",
  #                     street_address: "1 Willow Lane",
  #                     city: "Hallow",
  #                     state: "ME",
  #                     zipcode: "99999"
  #                     })

  # event = Event.create({ name: 'Gandolf Grey',
  #                     description: 'Hunt for the hobbits in the shire',
  #                     date: 10.days.from_now,
  #                     start_time: "09:00 AM",
  #                     end_time: "11:00 AM",
  #                     location_id: location.id,
  #                     capacity: 12
  #                    })

  # RegistrationClient.create(role.id, event.id, user.id)
