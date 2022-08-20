Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  resources :activities, only: %i[index new create] do
    resources :reviews, only: %i[new create edit update]
  end
  resources :dogs, only: %i[index show new create]
  resources :activities, only: %i[index new create]
  resources :locations, only: %i[index new create]
end
