require 'net/http'
require 'uri'
require 'json'

namespace :app do
  desc "Update the list of servers"
  task :update_servers => :environment do
    url = "http://us.battle.net/api/wow/realm/status"
    uri = URI.parse url
    response = Net::HTTP.get_response uri
    body = response.body

    data = JSON.parse body

    if data["realms"].present?
      data["realms"].each do |realm|
        server = Server.find_by_slug realm["slug"]
        unless server
          Server.create({
            kind: realm["type"],
            name: realm["name"],
            slug: realm["slug"],
            battlegroup: realm["battlegroup"]
          })
        end
      end
    end
  end
end
