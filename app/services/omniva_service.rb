class OmnivaService
  def self.get
    response = Faraday.get('https://www.omniva.lt/locations.json')

    REDIS.set "omniva", response.body
  end
end