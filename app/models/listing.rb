require 'cgi'

class Listing < ActiveRecord::Base
  validates_inclusion_of :character_class, in: Wow::CLASSES.keys
  validates_inclusion_of :race, in: Wow::RACES.keys
  validates_inclusion_of :faction, in: Wow::FACTIONS.values.map(&:to_s)
  validates_inclusion_of :gender, in: [0, 1]
  validates_presence_of  :realm
  validates_presence_of  :character

  before_validation :set_faction_by_race
  before_save :set_battlegroup_by_realm

  def self.active
    where("updated_at > ?", 1.hour.ago).order("updated_at DESC")
  end

private

  def set_faction_by_race
    self.faction = Wow.faction_by_race(race) unless race.blank?
  end

  def set_battlegroup_by_realm
    server = Server.where(name: realm).first
    if server
      self.battlegroup = server.battlegroup
    end
  end
end
