FactoryGirl.define do

  factory :event do
    name "Stringy"
    description "fun " * 10
    location_id 2
    date 10.days.from_now
    start_time "14:00"
    end_time "21:00"
  end

  factory :location do
    venue "gSchool"
    street_address "123 Fake St"
    city "Denver"
    state "CO"
    zipcode "80204"
  end

  factory :role do
    identity "attendee"
  end

  factory :user do
    name "Adam"
    username "Adam89"
    sequence(:email) {|n| "Adam#{n}@factory.com" }
  end

  factory :registration do
    user_id 1
    role_id 1
    event_id 1
  end
end
