Rails.application.routes.draw do
  resources :genres
  resource :session
  get "signup" => "users#new"
  get "signin" => "sessions#new"
  get "signout" => "sessions#destroy"
  resources :users
  root "movies#index"

  get "movies/filter/:scope", to: "movies#index", as: "filtered_movies"

  resources :movies do
    resources :reviews do
      resources :likes
    end
    resources :favorites
  end
end
