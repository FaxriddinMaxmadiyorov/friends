Rails.application.routes.draw do
  resources :chat_rooms
  root "friends#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :friends
  get 'home/about'
  # get '/auth/:provider/callback' => 'sessions#omniauth'
end
