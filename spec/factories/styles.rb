FactoryBot.define do
  factory :style do
    name { Faker::Beer.style }
    school_brewery { Faker::University.name }
    user
  end
end
