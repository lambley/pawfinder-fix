Rails.application.routes.draw do
  root to: "pages#home"
  get "/restaurant-search", to: "pages#restaurant"
  get "/park-search", to: "pages#park"
  get "/bin-search", to: "pages#bin"
  get "/dog-search", to: "pages#dog"
  get "/profile", to: "pages#profile"
  devise_for :users
  resources :activities, only: %i[index new create] do
    resources :reviews, only: %i[index new create edit update]
    resources :favourites, only: %i[create destroy]
  end
  resources :dogs, only: %i[index show new create] do
    resources :favourites, only: %i[create destroy]
  end
  resources :activities, only: %i[index new create]
  resources :locations, only: %i[index new create]
end
