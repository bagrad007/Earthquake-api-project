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
      puts "The magnitude is #{location.mag}. This type of quake is rarely felt, but can be recorded by a seismograph. It's estimated that over a million micro to minor type quakes per year."
      puts "You're more likely to feel a fart than this quake."
      self.prompt_place_or_exit
      puts "--------------"
    elsif input == 1 && location.mag.between?(3, 3.9)
      puts "The magnitude is #{location.mag}. This type of quake is felt noticeably by persons indoors, especially on upper floors of buildings. Standing motor cars may rock slightly. Vibrations are similar to the passing of a truck. An estimated 100,000 minor type quakes happen a year."
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(4, 4.9)
      puts "The magnitude is #{location.mag}. This type of quake is felt indoors by many, outdoors by few. Dishes can be disturbed, some windows can be broken, and the walls can make a cracking sound. An estimated 10,000 light type quakes happen per year."
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(5, 5.9)
      puts "The magnitude is #{location.mag}. This type of quake is felt by most people. Can possibly cause broken plaster and chimneys to buildings. An estimated 1,000 moderate type quakes happen per year."
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(6, 6.9)
      puts "The magnitude is #{location.mag}. Damage will vary based on how well the construction of the building was made. Poorly built buildings will sustain considerable damage, while buildings with good design and construction will have negligible damage. An estimated 130 strong type quakes happen each year."
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(7, 7.9)
      puts "The magnitude is #{location.mag}. Damage will be considerable in specially designed structures, with well-designed frame structures thrown out of plumb. Buildings can sustain partial collapse and be shifted off foundations. An estimated 15 major type quakes happen per year."
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(8, 8.9)
      puts "The magnitude is #{location.mag}. "
      self.prompt_for_place
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
