class ParcelMachine < ApplicationRecord
  def self.store_json 
    response = Faraday.get('https://www.omniva.lt/locations.json')

    REDIS.set "omniva", response.body
  end
end
