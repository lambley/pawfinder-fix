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
end
