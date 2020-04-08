Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', registrations: 'registrations' }
  resources :profiles, only: %i[show edit update]
  resources :cards, only: %i[index new create destroy]
  resources :users, only: %i[index] do
    member do
      patch 'lock'
      patch 'unlock'
      patch 'make_admin'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
