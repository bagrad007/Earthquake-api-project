class Cli
  def welcome
    puts "--------------"
    puts "Welcome to Earthquake Tracker, where we track your quakes!"
    self.prompt_for_place
  end

  def prompt_for_place
    puts "Please enter a Zip code, or city and state in this format [city, state] to get started!"
    puts "Type exit to leave anytime!"
    input = gets.strip
    location = Api.get_report_by_place(input)
    if location
      puts "--------------"
      puts "The nearest earthquake is #{location.region}."
      puts "--------------"
      self.info_options(location)
    elsif input.downcase == "exit"
      self.exit_method
    else
      self.invalid_selection(location)
    end
  end

  def info_options(location)
    puts "Would you like more information on the quake?"
    puts "1. Yes"
    puts "2. No, I'd like to enter another zip"
    input = gets.strip
    if input.to_i == 1 && location.mag <= 3
      self.micro_quake(location)
    elsif input.to_i == 1 && location.mag.between?(3.1, 3.9)
      self.minor_quake(location)
    elsif input.to_i == 1 && location.mag.between?(4, 4.9)
      self.light_quake(location)
    elsif input.to_i == 1 && location.mag.between?(5, 5.9)
      self.moderate_quake(location)
    elsif input.to_i == 1 && location.mag.between?(6, 6.9)
      self.strong_quake
    elsif input.to_i == 1 && location.mag.between?(7, 7.9)
      self.major_quake
    elsif input.to_i == 1 && location.mag.between?(8, 8.4)
      self.great_quake(location)
    elsif input.to_i == 1 && location.mag.between?(8.5, 8.9)
      self.very_great_quake(location)
    elsif input.to_i == 1 && location.mag >= 9
      self.strongest_quake
    elsif input.to_i == 2
      self.prompt_for_place
    elsif input == "exit"
      self.exit_method
    else
      self.invalid_selection(location)
    end
    self.prompt_place_or_exit
  end

  def micro_quake(location)
    puts "--------------"
    puts "The magnitude is #{location.mag}. This type of quake is rarely felt, but can be recorded by a seismograph."
    puts "It's estimated that over a million micro to minor type quakes happen per year."
    puts "You're more likely to feel a fart than this quake."
  end

  def minor_quake(location)
    puts "--------------"
    puts "The magnitude is #{location.mag}. This type of quake is felt noticeably by persons indoors, especially on upper floors of buildings."
    puts "Standing motor cars may rock slightly. Vibrations are similar to the passing of a truck."
    puts "An estimated 100,000 minor type quakes happen a year."
  end

  def light_quake(location)
    puts "--------------"
    puts "The magnitude is #{location.mag}. This type of quake is felt indoors by many, outdoors by few. "
    puts "Dishes can be disturbed, some windows can be broken, and the walls can make a cracking sound."
    puts "An estimated 10,000 light type quakes happen per year."
  end

  def moderate_quake(location)
    puts "--------------"
    puts "The magnitude is #{location.mag}. This type of quake is felt by most people."
    puts "Can possibly cause broken plaster and chimneys to buildings."
    puts "An estimated 1,000 moderate type quakes happen per year."
  end

  def strong_quake(location)
    puts "--------------"
    puts "The magnitude is #{location.mag}. Damage will vary based on how well the construction of the building was made."
    puts "Poorly built buildings will sustain considerable damage, while buildings with good design and construction will have negligible damage."
    puts "An estimated 130 strong type quakes happen each year."
  end

  def major_quake(location)
    puts "--------------"
    puts "The magnitude is #{location.mag}. Damage will be considerable in specially designed structures, with well-designed frame structures thrown out of plumb."
    puts "Buildings can sustain partial collapse and be shifted off foundations."
    puts "An estimated 15 major type quakes happen per year."
  end

  def great_quake(location)
    puts "--------------"
    puts "The magnitude is #{location.mag}. Some well-built wooden structures destroyed."
    puts "Most masonry and frame stuctures destroyed along with the foundations. Rails will be bent."
    puts "It's estimated that only 1 of these great type quakes happen every year."
  end

  def very_great_quake(location)
    puts "The magnitude is #{location.mag}. Few, if any (masonry) structures remain standing."
    puts "Bridges and many buildings will be destroyed, and railings will be greatly bent."
    puts "It's estimated only 1 or less very great type quakes happen per year."
  end

  def strongest_quake(location)
    puts "The magnitude is #{location.mag}. Damage is total. Lines of sight and level are distorted and objects will be thrown into the air."
    puts "Extensive damage over broad areas."
    puts "It's estimated that only 1 great quake happens in every 5 to 10 years of this magnitude."
  end

  def invalid_selection(location)
    puts "Invalid selection, please try again!"
    self.info_options(location)
  end

  def prompt_place_or_exit
    puts "Would you like to search another location?"
    puts "1. Yes"
    puts "2. I'm done for now, thank you!"
    input = gets.strip.downcase

    if input == "1"
      self.prompt_for_place
    elsif input == "exit"
      self.exit_method
    else
      self.exit_method
    end
  end

  def exit_method
    exit!
  end
end
