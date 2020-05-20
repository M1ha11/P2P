require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', registrations: 'registrations' }
  
  root 'claims#index'

  resources :profiles, only: %i[show edit update]
  resources :cards, only: %i[index new create destroy]
  resources :claims do
    resources :comments, only: %i[new create destroy]
  end
  resources :users, only: %i[index] do
    member do
      patch 'lock'
      patch 'unlock'
      patch 'change_role'
    end
  end

  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
