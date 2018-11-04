FactoryBot.define do
  factory :beer do
    name { 'Black Forest Schwarzbier' }
    style { 1 }
    abv { '6%' }
    ibu { '28' }
    nationality { 'Salt Lake City, Utah US' }
    brewery { 'Squatters Craft Beers' }
    description { 'A deeply enchanting German style lager brewed with Pilsner, Munich, Special B, and a forest of dark malts. Lightly hopped with 100% German Noble hops, it has bewitchingly smooth roast undertones and a fairy tale finish.' }
  end
end
