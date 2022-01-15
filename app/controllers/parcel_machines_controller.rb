class ParcelMachinesController < ApplicationController

  def index
    json = REDIS.get "omniva"

    parsed_response = JSON.parse(json)

    @parcel_machines = ParcelMachinesDecorator.decorate_collection(parsed_response)
  end

  def show

  end
end
