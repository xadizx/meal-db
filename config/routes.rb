Rails.application.routes.draw do
  mount MissionControl::Jobs::Engine, at: "/jobs" if Rails.env.development?

  devise_for :users, only: [:sessions, :registrations]

  root "homepage#index"

  resources :meals, only: [:index, :show], param: :external_id do
    collection do
      get :browse
      get :random
    end

    member do
      resources :reviews, only: [:create], as: :meal_reviews
      put :favourite, to: "meals#toggle_favourite", as: :toggle_favourite
    end
  end

  resources :reviews, only: [:index, :destroy]
end
