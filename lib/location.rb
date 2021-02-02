require "pry"

class Location
  attr_accessor :mag, :type, :region, :profile
  @@all = []

  def initialize(hash)
    hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def self.all
    @@attribute_array
  end
end
