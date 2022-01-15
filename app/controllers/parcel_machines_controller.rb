class ParcelMachinesController < ApplicationController

  def index
    response ||= Faraday.get('https://www.omniva.lt/locations.json')

    parcel_machines = JSON.parse(response.body)
  end

  def show

  end
end
