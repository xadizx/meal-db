Rails.application.routes.draw do
  mount MissionControl::Jobs::Engine, at: "/jobs" if Rails.env.development?

  root "homepage#index"

  devise_for :users, only: [:sessions, :registrations]

  resources :meals, only: [:index, :show], param: :external_id do
    collection do
      get :favourite
      get :random
      post :filter
    end

    member do
      resources :reviews, only: [:create], as: :meal_reviews
      put :favourite, to: "meals#toggle_favourite", as: :toggle_favourite
    end
  end

  resource :swipe, only: [:show, :create], controller: :swipes

  resources :reviews, only: [:index, :destroy]
end
