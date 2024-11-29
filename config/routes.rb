Rails.application.routes.draw do
  devise_for :users

  resources :categories, only: [:index] do
    member do
      get :articles
    end
  end

  resources :articles, only: [:index, :show, :create, :update, :destroy]

  root to: "home#index"
end
