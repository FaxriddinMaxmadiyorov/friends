Rails.application.routes.draw do
  resources :messages
  resources :chat_rooms
  root "friends#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :friends do
    post :initialize_chat, on: :member
    get :private_chat, on: :member
  end
  get 'home/about'
  # get '/auth/:provider/callback' => 'sessions#omniauth'
end
