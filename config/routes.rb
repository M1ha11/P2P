Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', registrations: 'registrations' }
  # resources :users
  resources :profiles, only: %i[show edit update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end