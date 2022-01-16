class ParcelMachinesSpreadsheetsController < ApplicationController
  def index
    table_data = File.read("#{Rails.root}/tmp/parcel_machines.xlsx")
    respond_to do |format|
      format.xlsx { send_data table_data }
    end
  end
end
