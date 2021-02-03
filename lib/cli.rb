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
    if input == 1 && location.mag <= 2.5
      print "The magnitude is #{location.mag}. This type of quake is usually not felt, but can be recorded by a seismograph. There are an estimated 900,000 minor type quakes per year."
      puts "You're more likely to feel a fart than this quake"
      self.info_options(location)
      puts "--------------"
    elsif input == 1 && location.mag.between?(2.5, 5.4)
      puts "The magnitude is #{location.mag}. This type of quake is often felt, but only causes minor damage. An estimated 30,000 light type quakes happen a year!"
      puts "If Bob doesn't tie down his belongings, Linda will have broken dishes!"
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(5.5, 6)
      puts "The magnitude is #{location.mag}. This type of quake can cause slight damage to buildings and other structures. An estimated 500 moderate type quakes happen per year!"
      self.prompt_place_or_exit
    elsif input == 1 && location.mag.between?(6.1, 6.9)
      puts "The magnitude is #{location.mag}. This type of quake may cause a lot of damage in very populated areas. An estimated 100 strong type quakes per year!"
    elsif input == 1 && location.mag.between?(7, 7.9)
      puts "The magnitude is #{location.mag}. This is a major earthquake. It will cause serious damage to anything within it's radius. An estimated 20 major type quakes happen each year!"
    elsif input == 1 && location.mag >= 8
      puts "The magnitude is #{location.mag}. This is a Great earthquake. It can totally destroy communities near the epicenter. An estimated one Great quake happens every 5-10 years"
    elsif input == 2
      self.prompt_place
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
