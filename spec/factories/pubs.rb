FactoryBot.define do
  factory :pub do
    name { Faker::LordOfTheRings.location }
    country { Faker::Address.country }
    state { Faker::Address.state_abbr }
    city { Faker::Address.city }
  end
end

# Use to seed
# name { 'Delirium Cafe' }
# country { 'Belgium' }
# state { 'BE' }
# city { 'Brussels' }
