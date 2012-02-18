require 'cgi'

class Listing < ActiveRecord::Base
  validates_inclusion_of :character_class, in: Wow::CLASSES.keys
  validates_inclusion_of :race, in: Wow::RACES.keys
  validates_inclusion_of :faction, in: %w[ alliance horde ]
  validates_presence_of  :realm
  validates_presence_of  :character

  before_validation :set_faction_by_race

  def self.active
    where("created_at > ?", 1.hour.ago).order("created_at DESC")
  end

  # TODO: Move to presenter
  def character_url
    realm = CGI.escape self.realm
    character = CGI.escape self.character
    "http://us.battle.net/wow/en/character/#{realm}/#{character}/advanced"
  end

private

  def set_faction_by_race
    self.faction = Wow.faction_by_race(race) unless race.blank?
  end
end
