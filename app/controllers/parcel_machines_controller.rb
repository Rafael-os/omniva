class ParcelMachinesController < ApplicationController
  def index
    if params[:q].present?
      params[:q].strip!

      @parcel_machines = search_query(params["field"])
    else
      @parcel_machines = ParcelMachinesDecorator.decorate_collection(parsed_response)
    end

    table_xls
  end

  def show
    parcel_machine = parsed_response.find { |pm| pm[:NAME] == params["id"] }

    @parcel_machine = ParcelMachinesDecorator.decorate(parcel_machine)
  end

  private

  def parsed_response
    response = REDIS.get "omniva"

    JSON.parse(response, symbolize_names: true)
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def search_query(column)
    filtered_parcel_machines = case column
                               when "zip"
                                 parsed_response.select { |h| h[:ZIP].include?(params[:q]) }
                               when "name"
                                 parsed_response.select { |h| h[:NAME].include?(params[:q]) }
                               else
                                 parsed_response.select do |h|
                                   h[:A0_NAME].include?(params[:q]) ||
                                     h[:A1_NAME].include?(params[:q]) ||
                                     h[:A2_NAME].include?(params[:q]) ||
                                     h[:A3_NAME].include?(params[:q]) ||
                                     h[:A4_NAME].include?(params[:q]) ||
                                     h[:A5_NAME].include?(params[:q]) ||
                                     h[:A6_NAME].include?(params[:q]) ||
                                     h[:A7_NAME].include?(params[:q]) ||
                                     h[:A8_NAME].include?(params[:q])
                                 end
                               end
    ParcelMachinesDecorator.decorate_collection(filtered_parcel_machines)
  end

  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def table_xls
    data = @parcel_machines.object

    CSV.open("tmp/parcel_machines.xlsx", "wb", col_sep: ",") do |csv|
      csv << data.first.keys
      data.each do |hash|
        csv << hash.values
      end
    end
  rescue
    redirect_to root_path, notice: "No records found"
  end
end
