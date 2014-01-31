# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  user = User.create({
          email: "agsiegert@hotmail.com",
          username: nil,
          provider: "facebook",
          uid: "536753365",
          name: "Antony Siegert",
          oauth_token: "CAADOUxTaZBssBAEZBrs08IVr4d8XwhtfZAOB4J9sy6lguXRryd...",
          oauth_expires_at: "2014-03-31 17:49:46",
          avatar: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash2/t5/186388_536753365_1031627958_q.jpg"
          })

  Role.create([{ identity: 'attendee' },
                { identity: 'creator'}])

  role = Role.last

  location = Location.create({
                      venue: "The Shire",
                      street_address: "1 Willow Lane",
                      city: "Hallow",
                      state: "ME",
                      zipcode: "99999"
                      })

  event = Event.create({ name: 'Gandolf Grey',
                      description: 'Hunt for the hobbits in the shire',
                      date: 10.days.from_now,
                      start_time: "09:00 AM",
                      end_time: "11:00 AM",
                      location_id: location.id,
                      capacity: 12
                     })

  Registration.create({ user_id: user.id,
                         event_id: event.id,
                         role_id: role.id
                         })
