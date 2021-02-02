class Cli
  def welcome
    puts "Welcome to Earthquake Tracker, where we track your quakes!"
    self.prompt_for_place
  end

  def prompt_for_place
    puts "Please enter a Zip code, or city and state in this format [city, state] to get started!"
    input = gets.strip
    location = Api.get_report_by_place(input)
    # binding.pry
    if location
      puts "--------------"
      puts "The nearest earthquake is #{location.region}."
      puts "--------------"
      self.ask_for_info(location)
    else
      puts "That location is invalid, please try again"
      puts "--------------"
      self.prompt_for_place
    end
  end

  def ask_for_info(location)
    puts "Would you like some information on the quake?"
    puts "--------------"
    puts "1. Yes"
    puts "2. No, I'd like to enter another zip"
    puts "3. I'm done for now thanks!"
    input = gets.strip.to_i
    # binding.pry
    if input == 1
      self.info_options(location)
    elsif input == 2
      self.prompt_for_place
    elsif input == 3
      exit!
    else
      puts "--------------"
      puts "Invalid choice, try again!"
      self.ask_for_info(location)
    end
  end

  def info_options(location)
    puts "--------------"
    puts "Select the info you'd like to see on the quake"
    puts "1. The magnitude of the quake"
    puts "2. The type of quake"
    puts "3. I'd like to find another quake!"
    input = gets.strip.to_i
    # binding.pry
    if input == 1
      puts "The magnitude is equal to #{location.mag}."
      self.info_options(location)
      puts "--------------"
    elsif input == 2
      puts "The type of the quake was a #{location.type} type."
      self.info_options(location)
      puts "--------------"
    elsif input == 3
      self.prompt_for_place
    else
      puts "Invalid selection, pick a different one!"
      self.info_options(location)
    end
  end
end
