class ListingPresenter
  def initialize(model, template)
    @template = template
    @model = model
  end

  def faction_icon
    if @model.faction == "alliance"
      h.image_path "blizzard/faction_0.jpg"
    else
      h.image_path "blizzard/faction_1.jpg"
    end
  end

  def race_icon
    h.image_path "blizzard/race_#{@model.race}_#{@model.gender}.jpg"
  end

  def class_icon
    h.image_path "blizzard/class_#{@model.character_class}.jpg"
  end

  def spec_icon(spec)
    image = Wow::SPECS[@model.character_class][spec]
    h.image_path "blizzard/spell/#{image}.jpg"
  end

  def bnet_url
    realm = CGI.escape @model.realm
    character = CGI.escape @model.character
    "http://us.battle.net/wow/en/character/#{realm}/#{character}/advanced"
  end

  def class_name
    Wow::CLASSES[@model.character_class]
  end

  def as_json(options)
    @model.attributes.merge({
      faction_icon: self.faction_icon,
      race_icon: self.race_icon,
      class_icon: self.class_icon,
      main_spec_icon: self.spec_icon(@model.main_spec),
      off_spec_icon: self.spec_icon(@model.off_spec),
      class_name: self.class_name,
      bnet_url: self.bnet_url,
      time_in_list: ((Time.now - @model.updated_at) / 60).floor
    }).as_json(options)
  end

private

  def h
    @template
  end
end
