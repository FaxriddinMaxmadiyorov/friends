Rails.application.routes.draw do
  root "friends#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :friends
  resources :rooms, only: %i[show]
  get 'home/about'
  # get '/auth/:provider/callback' => 'sessions#omniauth'
end
