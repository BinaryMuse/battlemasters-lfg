require 'uri'

class ListingPresenter
  def initialize(model, template)
    @template = template
    @model = model
  end

  def faction_sprite
    if @model.faction == "alliance"
      "faction_0"
    else
      "faction_1"
    end
  end

  def race_sprite
    "race_#{@model.race}_#{@model.gender}"
  end

  def class_sprite
    "class_#{@model.character_class}"
  end

  def spec_sprite(spec)
    Wow::SPECS[@model.character_class][spec]
  end

  def bnet_url
    realm = URI.escape @model.realm
    character = URI.escape @model.character
    "http://us.battle.net/wow/en/character/#{realm}/#{character}/advanced"
  end

  def class_name
    Wow::CLASSES[@model.character_class]
  end

  def as_json(options)
    @model.attributes.merge({
      faction_sprite: self.faction_sprite,
      race_sprite: self.race_sprite,
      class_sprite: self.class_sprite,
      main_spec_sprite: self.spec_sprite(@model.main_spec),
      off_spec_sprite: self.spec_sprite(@model.off_spec),
      class_name: self.class_name,
      bnet_url: self.bnet_url,
      time_in_list: (Time.now - @model.updated_at).floor
    }).as_json(options)
  end

private

  def h
    @template
  end
end
