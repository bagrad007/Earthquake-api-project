class Api
  @@api_key = "CfLh8ssEDtxbhdlH1hLNn9vSOSP3z8ZGcUDOoCHu"
  def self.get_report_by_place(place)
    url = "https://api.aerisapi.com/earthquakes/closest?p=#{place}&radius=3000miles&client_id=TPgjRDTtKBBQd4Q2fLI3c&client_secret=#{@@api_key}"
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
