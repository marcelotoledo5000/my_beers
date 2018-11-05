FactoryBot.define do
  factory :pub do
    name { Faker::LordOfTheRings.location }
    country { Faker::Address.country }
    state { Faker::Address.state_abbr }
    city { Faker::Address.city }
    user
  end
end
