Rails.application.routes.draw do
  resource :session
  get "signup" => "users#new"
  get "signin" => "sessions#new"
  get "signout" => "sessions#destroy"
  resources :users
  root "movies#index"
  resources :movies do
    resources :reviews
  end
end
