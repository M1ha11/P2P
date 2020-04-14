Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', registrations: 'registrations' }
  
  root 'claims#index'

  resources :profiles, only: %i[show edit update]
  resources :cards, only: %i[index new create destroy]
  resources :claims do
    resources :comments, only: %i[index new create destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
