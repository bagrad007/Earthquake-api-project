class Cli
  def welcome
    puts "Welcome to the Earthquake CLI app!"
    self.prompt_for_zip
  end

  def prompt_for_zip
    input = gets.strip
  end
end
