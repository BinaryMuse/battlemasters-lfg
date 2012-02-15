module ListingsHelper
  def image_tag_for_faction(faction, *args)
    if faction == "alliance"
      image_tag "blizzard/faction_0.jpg", *args
    else
      image_tag "blizzard/faction_0.jpg", *args
    end
  end

  def image_tag_for_spec(klass, spec, *args)
    image = Wow::SPECS[klass][spec]
    image_tag "blizzard/spell/#{image}.jpg", *args
  end

  def options_for_spec_select
    options = []
    Wow::SPECS.each do |klass, specs|
      specs.each do |name, icon|
        options << [name, name, {'data-class' => klass}]
      end
    end
    options
  end

  def time_in_list(start_time)
    end_time = Time.now
    diff = end_time - start_time
    if diff < 1.minute
      "<1 min"
    elsif diff < 59.minutes
      min = diff / 1.minute
      "#{min.floor} min"
    else
      ">1 hour"
    end
  end
end
