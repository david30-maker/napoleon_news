Rails.application.routes.draw do
  devise_for :users

  resources :categories, only: [:index] do
    member do
      get :articles
    end
  end

  root to: "home#index"
end
