Rails.application.routes.draw do
  get 'dog/index'
  get 'dog/show'
  get 'dog/new'
  get 'dog/create'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :dogs, only: %i[index show new create]
end
