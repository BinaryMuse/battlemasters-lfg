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

namespace :app do
  desc "Delete listings more than an hour old"
  task :delete_old_listings => :environment do
    Listing.where("created_at < ?", 1.hour.ago).destroy_all
  end

  desc "Generate a bunch of fake listings"
  task :generate_listings => :environment do
    10.times do
      klass = Wow::CLASSES.keys.sample
      Listing.create!({
        character: Faker::Name.first_name,
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
        notes: Faker::Lorem.sentence
      })
    end
  end
end
