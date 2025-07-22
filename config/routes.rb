Rails.application.routes.draw do
  mount MissionControl::Jobs::Engine, at: "/jobs" if Rails.env.development?

  devise_for :users, only: [:sessions, :registrations]

  root "homepage#index"

  resources :dashboard, only: [:index]
end
