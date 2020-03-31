Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', registrations: 'registrations' }
  resources :profiles, only: %i[show edit update]
<<<<<<< HEAD
  resources :claims
=======
  resources :cards, only: %i[index new create destroy]
>>>>>>> 308f1799e95e2bcd7440b26970a11e29345bb034
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
