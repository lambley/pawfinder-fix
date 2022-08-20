Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  get 'reviews/edit'
  get 'reviews/update'
  devise_for :users
  root to: "pages#home"
  resources :activities, only: %i[index new create] do
    resources :reviews, only: %i[new create edit update]
  end
  get 'dog/index'
  get 'dog/show'
  get 'dog/new'
  get 'dog/create'
  get 'activities/index'
  get 'activities/new'
  get 'activities/create'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :dogs, only: %i[index show new create]
  resoureces :activities, only: %i[index new create]
end
