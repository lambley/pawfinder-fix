Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  resources :activities, only: %i[index new create] do
    resources :reviews, only: %i[new create edit update]
  end
  resources :dogs, only: %i[index show new create]
  resources :activities, only: %i[index new create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
