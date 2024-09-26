Rails.application.routes.draw do

  root "reservations#index"

  resources :reservations
  resources :bicycles
  resources :employees

  get "up" => "rails/health#show", as: :rails_health_check

  get 'reservations/:id/cancel', to: 'reservation_cancellations#cancel', as: 'reservation_cancellation'


end
