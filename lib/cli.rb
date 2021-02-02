class Cli
  def welcome
    puts "Welcome to Earthquake Tracker, where we track your quakes!"
    self.prompt_for_place
  end

  def prompt_for_place
    puts "Please enter a Zip code to get started!"
    input = gets.strip
    location = Api.get_report_by_place(input)
    # binding.pry
    puts "The nearest earthquake is #{location.region}."
    self.info_options(location)
  end

  def info_options(location)
    puts "Select the info you'd like to see on the quake"
    puts "1. The magnitude of the quake"
    puts "2. The type of quake"
    input = gets.strip.to_i
    # binding.pry
    if input == 1
      puts "The magnitude is equal to #{location.mag}."
    elsif input == 2
      puts "The type of the quake was a #{location.type} type."
    else
      puts "Invalid selection, pick a different one!"
      self.info_options(location)
    end
  end
end
