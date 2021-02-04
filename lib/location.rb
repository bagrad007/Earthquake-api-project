class Location
  attr_accessor :mag, :region

  def initialize(hash)
    hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end
end
