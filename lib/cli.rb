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

  # def ask_for_info(location)
  #   puts "Would you like some information on the quake?"
  #   puts "--------------"
  #   puts "1. Yes"
  #   puts "2. No, I'd like to enter another zip"
  #   input = gets.strip.to_i
  #   # binding.pry
  #   if input == 1
  #     self.info_options(location)
  #   elsif input == 2
  #     self.prompt_for_place
  #   elsif input == "exit" || "Exit"
  #     self.exit_method
  #   else
  #     puts "--------------"
  #     puts "Invalid choice, try again!"
  #     self.ask_for_info(location)
  #   end
  # end

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
      puts "The magnitude is #{location.mag}. This type of quake is often felt, but only causes minor damage. An estimated 30,000 of them happen a year!"
      puts "If Bob doesn't tie down his belongings, Linda will have broken dishes!"
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
