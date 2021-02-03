class Cli
  def welcome
    puts "--------------"
    puts "Welcome to Earthquake Tracker, where we track your quakes!"
    self.prompt_for_place
  end

  def prompt_for_place
    puts "Please enter a Zip code, or city and state in this format [city, state] to get started!"
    puts "Type exit to leave anytime!"
    input = gets.strip.downcase
    location = Api.get_report_by_place(input)
    # binding.pry
    if location
      puts "--------------"
      puts "The nearest earthquake is #{location.region}."
      puts "--------------"
      self.info_options(location)
    elsif input == "exit"
      self.exit_method
    else
      puts "That location is invalid, please try again"
      puts "--------------"
      self.prompt_for_place
    end
  end

  def info_options(location)
    puts "Would you like more information on the quake?"
    puts "1. Yes"
    puts "2. No, I'd like to enter another zip"
    input = gets.strip.to_i
    # binding.pry
    if input == 1 && location.mag <= 3
      puts "The magnitude is #{location.mag}. This type of quake is rarely felt, but can be recorded by a seismograph."
      puts "It's estimated that over a million micro to minor type quakes happen per year."
      puts "You're more likely to feel a fart than this quake."
      self.prompt_place_or_exit
      puts "--------------"
    elsif input == 1 && location.mag.between?(3, 3.9)
      puts "The magnitude is #{location.mag}. This type of quake is felt noticeably by persons indoors, especially on upper floors of buildings."
      puts "Standing motor cars may rock slightly. Vibrations are similar to the passing of a truck."
      puts "An estimated 100,000 minor type quakes happen a year."
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(4, 4.9)
      puts "The magnitude is #{location.mag}. This type of quake is felt indoors by many, outdoors by few. "
      puts "Dishes can be disturbed, some windows can be broken, and the walls can make a cracking sound."
      puts "An estimated 10,000 light type quakes happen per year."
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(5, 5.9)
      puts "The magnitude is #{location.mag}. This type of quake is felt by most people."
      puts "Can possibly cause broken plaster and chimneys to buildings."
      puts "An estimated 1,000 moderate type quakes happen per year."
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(6, 6.9)
      puts "The magnitude is #{location.mag}. Damage will vary based on how well the construction of the building was made."
      puts "Poorly built buildings will sustain considerable damage, while buildings with good design and construction will have negligible damage."
      puts "An estimated 130 strong type quakes happen each year."
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(7, 7.9)
      puts "The magnitude is #{location.mag}. Damage will be considerable in specially designed structures, with well-designed frame structures thrown out of plumb."
      puts "Buildings can sustain partial collapse and be shifted off foundations."
      puts "An estimated 15 major type quakes happen per year."
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(8, 8.4)
      puts "The magnitude is #{location.mag}. Some well-built wooden structures destroyed; most masonry and frame stuctures destroyed along with the foundations. Rails will be bent. It's estimated that only 1 of these great type quakes happen every year."
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(8.5, 8.9)
      puts "The magnitude is #{location.mag}. Few, if any (masonry) structures remain standing. Bridges and many buildings will be destroyed, and railings will be greatly bent. It's estimated only 1 or less great type quakes happen per year."
      self.prompt_place_or_exit
    elsif input == 1 && location.mag >= 9
      puts "The magnitude is #{location.mag}. Damage is total. Lines of sight and level are distorted and objects will be thrown into the air. Extensive damage over broad areas. It's estimated that only 1 great quake happens in every 5 to 10 years of this magnitude."
      self.prompt_place_or_exit
    elsif input == 2
      self.prompt_for_place
    elsif input == "exit"
      self.exit_method
    else
      puts "Invalid selection, pick a different one!"
      self.info_options(location)
    end
  end

  def prompt_place_or_exit
    puts "Would you like to search another location?"
    puts "1. Yes"
    puts "2. I'm done for now, thank you!"

    input = gets.strip.to_i

    if input == 1
      self.prompt_for_place
    else
      self.exit_method
    end
  end

  def exit_method
    exit!
  end
end
