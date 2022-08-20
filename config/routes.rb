Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  get 'reviews/edit'
  get 'reviews/update'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
