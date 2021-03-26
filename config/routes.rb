Rails.application.routes.draw do
  devise_for :admins
  root 'articles#index'

  resources :test_articles, only: :index
  resources :articles do
    resources :comments
  end
end
