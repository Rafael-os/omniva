class ParcelMachinesController < ApplicationController

  def index
    json = REDIS.get "omniva"

    @parcel_machines = JSON.parse(json)
  end

  def show

  end
end
