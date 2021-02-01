require "pry"
require "httparty"

class Api
  @@api_key = "CfLh8ssEDtxbhdlH1hLNn9vSOSP3z8ZGcUDOoCHu"

  def self.get_report_by_zip(zip)
    url = "https://api.aerisapi.com/earthquakes/closest?p=#{zip}&client_id=TPgjRDTtKBBQd4Q2fLI3c&client_secret=#{@@api_key}"
    response = HTTParty.get(url)
    binding.pry
  end
end

Api.get_report_by_zip(90210)
