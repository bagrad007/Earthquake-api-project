class Api
  @@api_key = "CfLh8ssEDtxbhdlH1hLNn9vSOSP3z8ZGcUDOoCHu"

  def self.get_report_by_zip(zip)
    url = "https://api.aerisapi.com/earthquakes/"
    response = HTTParty.get(url)
    binding.pry
  end
end
