Rails.application.routes.draw do
  devise_for :users

  resources :categories, only: [:index, :show] do
    member do
      get :articles
    end
  end

  resources :articles, only: [:new, :edit, :index, :show, :create, :update, :destroy] do
    member do
      patch :update_status
    end
  end
  
  root to: "home#index"

  resources :users, only: [:index] do
    resources :authored_articles, only: :index
    member do
      patch :update_role
    end
  end
end
