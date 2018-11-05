# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

german_style = Style.create(name: 'German-Style Schwarzbier', school_brewery: 'German School')
belgian_style = Style.create(name: 'Belgian-Style Dark Strong Ale', school_brewery: 'Belgian School')
english_style = Style.create(name: 'Robust Porter', school_brewery: 'British School')
american_style = Style.create(name: 'American-Style Double India Pale Ale', school_brewery: 'American School')

Beer.create([
  {
    name: 'Köstritzer Schwarzbier',
    style_id: german_style.id,
    abv: '4.8%',
    ibu: '22',
    nationality: 'Germany',
    brewery: 'Köstritzer',
    description: 'A deeply enchanting German style lager brewed with Pilsner, Munich, Special B, and a forest of dark malts. Lightly hopped with 100% German Noble hops, it has bewitchingly smooth roast undertones and a fairy tale finish.'
  },
  {
    name: 'Chimay Blue',
    style_id: belgian_style.id,
    abv: '9%',
    ibu: '35',
    nationality: 'Belgian',
    brewery: 'Bières de Chimay',
    description: 'Originally brewed as a Christmas beer in 1948, this dark ale has rich flavors of mulling spices and caramel, with a smooth palate and warming finish.'
  },
  {
    name: "Monk's Habit Robust Porter",
    style_id: english_style.id,
    abv: '6.5%',
    ibu: '30',
    nationality: 'Canadian',
    brewery: 'Troubled Monk Brewery',
    description: 'Balance between bitter and sweet, light and persistent.'
  },
  {
    name: 'KBS',
    style_id: american_style.id,
    abv: '11.9%',
    ibu: '70',
    nationality: 'American',
    brewery: 'Founders Brewing',
    description: 'What we’ve got here is an imperial stout brewed with a massive amount of coffee and chocolates, then cave-aged in oak bourbon barrels for an entire year to make sure wonderful bourbon undertones come through in the finish.'
  }
])

Pub.create([
  {
    name: 'Delirium Cafe',
    country: 'Belgium',
    state: 'BE',
    city: 'Brussels'
  },
  {
    name: 'Brewdog',
    country: 'Belgium',
    state: 'BE',
    city: 'Brussels'
  },
  {
    name: 'EAP',
    country: 'Brazil',
    state: 'SP',
    city: 'Sao Paulo'
  }
])
