Rails.application.routes.draw do
  devise_for :users, only: [:sessions, :registrations]

  if Rails.env.development?
    mount MissionControl::Jobs::Engine, at: "/jobs"
  end

  get "up" => "rails/health#show", :as => :rails_health_check

  root "pages#index"

  resources :dashboard, only: [:index]
end
