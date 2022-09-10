Rails.application.routes.draw do
  root to: "pages#home"
  # custom routes for home page search form AJAX
  get "/restaurant-search", to: "pages#restaurant"
  get "/park-search", to: "pages#park"
  get "/bin-search", to: "pages#bin"
  get "/dog-search", to: "pages#dog"
  # route for current user profile page
  get "/profile", to: "pages#profile"
  # route for current user review index
  get "/profile/reviews", to: "pages#profile_reviews"
  devise_for :users
  resources :activities, only: %i[index new create] do
    resources :reviews, only: %i[index new create edit update]
    resources :favourites, only: %i[create destroy]
  end
  resources :dogs, only: %i[index show new create] do
    resources :favourites, only: %i[create destroy]
    get "/owner", to: "pages#private_profile"
  end
  resources :activities, only: %i[index new create]
  resources :locations, only: %i[index new create]
end
