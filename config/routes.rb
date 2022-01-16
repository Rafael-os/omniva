Rails.application.routes.draw do
  resources :parcel_machines, only: %i[index show]
  resources :parcel_machines_spreadsheets, only: %i[index]

  root to: "parcel_machines#index"
end
