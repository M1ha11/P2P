Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', registrations: 'registrations' }
  
  root 'claims#index'

  resources :profiles, only: %i[show edit update]
  resources :cards, only: %i[index new create destroy]
<<<<<<< HEAD
  resources :claims do
    resources :comments, only: %i[index new create destroy]
  end
=======
  resources :users, only: %i[index] do
    member do
      patch 'lock'
      patch 'unlock'
      patch 'change_role'
    end
  end
  resources :claims
>>>>>>> 7deb7ed7ca4e1b7422173e16934fe833fb27af9b
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
