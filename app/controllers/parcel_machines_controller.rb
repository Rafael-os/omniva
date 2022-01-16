class ParcelMachinesController < ApplicationController
  def index
    if params[:q].present?
      @parcel_machines = search_query(params["field"])
    else
      @parcel_machines = ParcelMachinesDecorator.decorate_collection(parsed_response)
    end
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

  def search_query(column)
    if column == "zip"
      filtered_parcel_machines = parsed_response.select{ |h| h["ZIP"].include?(params[:q]) }
      ParcelMachinesDecorator.decorate_collection(filtered_parcel_machines)
    end
    if column == "name"
      filtered_parcel_machines = parsed_response.select{ |h| h["NAME"].include?(params[:q]) }
      ParcelMachinesDecorator.decorate_collection(filtered_parcel_machines)
    end
    if column == "address"
      filtered_parcel_machines = parsed_response.select{ |h| h["A0_NAME"].include?(params[:q]) ||
                                                             h["A1_NAME"].include?(params[:q]) ||
                                                             h["A2_NAME"].include?(params[:q]) || 
                                                             h["A3_NAME"].include?(params[:q]) || 
                                                             h["A4_NAME"].include?(params[:q]) || 
                                                             h["A5_NAME"].include?(params[:q]) || 
                                                             h["A6_NAME"].include?(params[:q]) || 
                                                             h["A7_NAME"].include?(params[:q]) ||
                                                             h["A8_NAME"].include?(params[:q])
                                                        }
      ParcelMachinesDecorator.decorate_collection(filtered_parcel_machines)
    end
  end
end
