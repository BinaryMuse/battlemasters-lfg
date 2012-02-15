module Wow
  RACES = {
    1  => :human,
    2  => :orc,
    3  => :dwarf,
    4  => :night_elf,
    5  => :undead,
    6  => :tauren,
    7  => :gnome,
    8  => :troll,
    9  => :goblin,
    10 => :blood_elf,
    11 => :draenei,
    22 => :worgen
  }

  ALLIANCE_RACES = [1, 3, 4, 7, 11, 22]
  HORDE_RACES    = [2, 5, 6, 8, 9, 10]

  def self.faction_by_race(faction)
    if ALLIANCE_RACES.include? faction
      "alliance"
    elsif HORDE_RACES.include? faction
      "horde"
    else
      nil
    end
  end

  GENDERS = {
    0 => :male,
    1 => :female
  }

  CLASSES = {
    1  => :warrior,
    2  => :paladin,
    3  => :hunter,
    4  => :rogue,
    5  => :priest,
    6  => :death_knight,
    7  => :shaman,
    8  => :mage,
    9  => :warlock,
    11 => :druid
  }

  SPECS = {
    1 => {
      "Protection" => "ability_warrior_defensivestance",
      "Arms" => "ability_warrior_savageblow",
      "Fury" => "ability_warrior_innerrage"
    },
    2 => {
      "Retribution" => "spell_holy_auraoflight",
      "Protection" => "ability_paladin_shieldofthetemplar",
      "Holy" => "spell_holy_holybolt"
    },
    3 => {
      "Survival" => "ability_hunter_camouflage",
      "Marksmanship" => "ability_hunter_focusedaim",
      "Beast Mastery" => "ability_hunter_bestialdiscipline"
    },
    4 => {
      "Combat" => "ability_backstab",
      "Subtlety" => "ability_stealth",
      "Assassination" => "ability_rogue_eviscerate"
    },
    5 => {
      "Discipline" => "spell_holy_powerwordshield",
      "Shadow" => "spell_shadow_shadowwordpain",
      "Holy" => "spell_holy_guardianspirit"
    },
    6 => {
      "Frost" => "spell_deathknight_frostpresence",
      "Unholy" => "spell_deathknight_unholypresence",
      "Blood" => "spell_deathknight_bloodpresence"
    },
    7 => {
      "Elemental" => "spell_nature_lightning",
      "Restoration" => "spell_nature_magicimmunity",
      "Enhancement" => "spell_nature_lightningshield"
    },
    8 => {
      "Fire" => "spell_fire_firebolt02",
      "Frost" => "spell_frost_frostbolt02",
      "Arcane" => "spell_holy_magicalsentry"
    },
    9 => {
      "Affliction" => "spell_shadow_deathcoil",
      "Demonology" => "spell_shadow_metamorphosis",
      "Destruction" => "spell_shadow_rainoffire"
    },
    11 => {
      "Balance" => "spell_nature_starfall",
      "Restoration" => "spell_nature_healingtouch",
      "Feral Combat" => "ability_racial_bearform"
    }
  }
end
