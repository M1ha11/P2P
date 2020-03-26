Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', registrations: 'registrations' }
  resources :profiles, only: %i[show edit update]
  resources :cards, only: %i[index new create destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
