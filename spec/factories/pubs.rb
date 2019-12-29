# frozen_string_literal: true

FactoryBot.define do
  factory :pub do
    name { Faker::Movies::LordOfTheRings.location }
    country { Faker::Address.country }
    state { Faker::Address.state_abbr }
    city { Faker::Address.city }
    user
  end
end
