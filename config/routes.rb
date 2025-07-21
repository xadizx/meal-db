Rails.application.routes.draw do
  if Rails.env.development?
    mount MissionControl::Jobs::Engine, at: "/jobs"
  end

  get "up" => "rails/health#show", :as => :rails_health_check

  # root "posts#index"
end
