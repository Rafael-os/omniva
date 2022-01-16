class ParcelMachinesController < ApplicationController

  def index
    get_json

    response = REDIS.get "omniva"

    parsed_response = JSON.parse(response)

    @parcel_machines = ParcelMachinesDecorator.decorate_collection(parsed_response)
  end

  def show

  end

  private

  def get_json
    return OmnivaService.call if (REDIS.get "omniva").nil?
  end
end
