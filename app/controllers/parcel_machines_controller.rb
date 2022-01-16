class ParcelMachinesController < ApplicationController
  def index
    @parcel_machines = ParcelMachinesDecorator.decorate_collection(parsed_response)
  end

  def show
    parcel_machine = parsed_response.find {|pm| pm["NAME"] = params["id"]}
    
    @parcel_machine = ParcelMachinesDecorator.decorate(parcel_machine)
  end

  private

  def parsed_response
    response = REDIS.get "omniva"

    JSON.parse(response)
  end
end
