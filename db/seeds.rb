require 'faker'

def realm_name
  %w(
    Aegwynn
    Cho'gall
    Dethecus
    Drenden
    Exodar
    Garrosh
    Grizzly Hills
    Kel'Thuzad
    Maiev
    Ravenholdt
  ).sample
end

Listing.delete_all
50.times do |n|
  klass = Wow::CLASSES.keys.sample
  Listing.create!({
    character: Faker::Name.first_name,
    gender: rand(2),
    realm: realm_name,
    race: Wow::RACES.keys.sample,
    character_class: klass,
    main_spec: Wow::SPECS[klass].keys.sample,
    off_spec: Wow::SPECS[klass].keys.sample,
    rating: rand(2500),
    rank: "Peon",
    resilience: rand(5000),
    item_level: (300..400).to_a.sample,
    irc_name: Faker::Name.first_name,
    notes: Faker::Lorem.sentence,
    created_at: rand(n * 5).minutes.ago
  })
end
