class Api
  def self.get_report_by_place(place)
    url = "https://api.aerisapi.com/earthquakes/closest?p=#{place}&radius=3000miles&client_id=TPgjRDTtKBBQd4Q2fLI3c&client_secret=#{ENV["API_KEY"]}"
    response = HTTParty.get(url)
    if response["error"]
      return false
    end
    location_hash = {
      mag: response["response"][0]["report"]["mag"],
      region: response["response"][0]["report"]["region"],
    }
    Location.new(location_hash)
  end
end
