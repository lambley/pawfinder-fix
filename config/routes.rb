Rails.application.routes.draw do
  get 'favourites/create', to: "favourites#create"
  get 'favourites/destroy', to: "favourites#destroy"
  root to: "pages#home"
  get "/restaurant-search", to: "pages#restaurant"
  get "/park-search", to: "pages#park"
  get "/bin-search", to: "pages#bin"
  get "/dog-search", to: "pages#dog"
  get "/profile", to: "pages#profile"
  devise_for :users
  resources :activities, only: %i[index new create] do
    resources :reviews, only: %i[new create edit update]
  end
  resources :dogs, only: %i[index show new create]
  resources :locations, only: %i[index new create]
end
