FactoryBot.define do
  factory :beer do
    name { Faker::Beer.name }
    style
    abv { Faker::Beer.alcohol }
    ibu { Faker::Beer.ibu }
    nationality { Faker::Nation.nationality }
    brewery { Faker::Company.buzzword }
    description { Faker::WorldOfWarcraft.quote }
  end
end
