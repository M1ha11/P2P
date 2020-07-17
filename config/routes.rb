require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', registrations: 'registrations' }
  
  # scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do  
  root 'claims#index'

  mount Sidekiq::Web => '/sidekiq'

  resources :profiles, only: %i[show edit update]
  resources :cards, only: %i[index new create destroy]
  resources :claims, except: %i[edit update] do
    member do
      patch 'confirm'
    end
    resources :comments, only: %i[new create destroy]
    resources :tags, only: %i[create]
    resources :taggings, only: %i[destroy]
  end
  resources :users, only: %i[index] do
    member do
      patch 'lock'
      patch 'unlock'
      patch 'change_role'
    end
  end
  resources :loan_participants, only: %i[create destroy]

  get 'search', to: 'search#search'
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
