Rails.application.routes.draw do
  get 'activities/index'
  get 'activities/new'
  get 'activities/create'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resoureces :activities, only: %i[index new create]
end
