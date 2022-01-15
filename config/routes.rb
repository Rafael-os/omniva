Rails.application.routes.draw do
  resources :parcel_machines, only: %i[index show]
  
  root to: 'parcel_machines#index'
end
