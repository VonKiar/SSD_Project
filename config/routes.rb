Rails.application.routes.draw do
  devise_for :admins
  root 'articles#index'

  resources :test_articles, only: :index

  namespace :articles do
    post 'csv_upload'
  end

  resources :articles do
    resources :comments
  end
end
