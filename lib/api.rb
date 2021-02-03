require "pry"
require "httparty"
require_relative "./location"

class Api
  @@api_key = "CfLh8ssEDtxbhdlH1hLNn9vSOSP3z8ZGcUDOoCHu"
  def self.get_report_by_place(place)
    url = "https://api.aerisapi.com/earthquakes/closest?p=#{place}&radius=3000miles&client_id=TPgjRDTtKBBQd4Q2fLI3c&client_secret=#{@@api_key}"
    response = HTTParty.get(url)
    if response["error"]
      return false
    end
    location_hash = {
      profile: response["response"][0]["profile"]["tz"],
      mag: response["response"][0]["report"]["mag"],
      region: response["response"][0]["report"]["region"],
      type: response["response"][0]["report"]["type"],
    }
    Location.new(location_hash)
  end

  def self.search_by_place(place)
    url = "https://api.aerisapi.com/earthquakes/#{place}?radius=15000miles&client_id=TPgjRDTtKBBQd4Q2fLI3c&client_secret=#{@@api_key}"
    response = HTTParty.get(url)
    binding.pry
    if response["error"]
      return false
    end
  end
end

Api.search_by_place(17036)
