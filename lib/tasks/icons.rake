# encoding: utf-8

require 'net/http'
require 'uri'
require 'json'

namespace :icons do
  desc "Download the spec icons"
  task :specs => :environment do
    dir = Rails.root.join("app", "assets", "images", "blizzard", "spell")
    downloaded_specs = []
    profiles = [
      "http://us.battle.net/wow/en/character/tichondrius/Mes/simple",
      "http://us.battle.net/wow/en/character/tichondrius/Mes/simple",
      "http://us.battle.net/wow/en/character/mugthol/Subtronix/simple",
      "http://us.battle.net/wow/en/character/kelthuzad/Thegodofdmg/simple",
      "http://us.battle.net/wow/en/character/kelthuzad/Ludachris/simple",
      "http://us.battle.net/wow/en/character/malganis/Peterb/simple",
      "http://us.battle.net/wow/en/character/kelthuzad/Kurum/simple",
      "http://us.battle.net/wow/en/character/lightbringer/Arrowsoftime/simple",
      "http://us.battle.net/wow/en/character/kelthuzad/Majinvenruki/simple",
      "http://us.battle.net/wow/en/character/arygos/Bottles/simple",
      "http://us.battle.net/wow/en/character/blackrock/Notchilli/simple",
      "http://us.battle.net/wow/en/character/black-dragonflight/Mikalol/simple",
      "http://us.battle.net/wow/en/character/kelthuzad/Sodez/simple",
      "http://us.battle.net/wow/en/character/barthilas/Cupcakeqt/simple",
      "http://us.battle.net/wow/en/character/tichondrius/Rzn/simple",
      "http://us.battle.net/wow/en/character/kelthuzad/Oribis/simple",
      "http://us.battle.net/wow/en/character/sargeras/Kask%C3%A5/simple",
      "http://us.battle.net/wow/en/character/kelthuzad/Jahmillz/simple",
      "http://us.battle.net/wow/en/character/kelthuzad/Drfilomd/simple",
      "http://us.battle.net/wow/en/character/barthilas/Jidox/simple",
      "http://us.battle.net/wow/en/character/kelthuzad/Xanaduz/simple",
      "http://us.battle.net/wow/en/character/kelthuzad/Sin%C3%ACx/simple"
    ]

    profiles.each do |profile|
      match = profile.match /character\/(.*)\/(.*)\/simple$/
      realm, char = match[1], match[2]

      url = "http://us.battle.net/api/wow/character/#{realm}/#{char}?fields=talents"
      uri = URI.parse url
      response = Net::HTTP.get_response uri
      body = response.body

      data = JSON.parse body
      data["talents"].each do |spec|
        downloaded_specs << data["class"].to_s + "-" + spec["name"]
        system "curl 'http://us.media.blizzard.com/wow/icons/18/#{spec['icon']}.jpg' >> '#{dir.join(spec["icon"] + ".jpg")}'"
      end
    end

    puts "Downloaded #{downloaded_specs.uniq.count} spec icons"
  end
end
