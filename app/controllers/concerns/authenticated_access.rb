module AuthenticatedAccess
  extend ActiveSupport::Concern

  included do
    before_action :require_user!

    layout "user"
  end

  private

  def require_user!
    redirect_to new_user_session_path, alert: "You must be signed in." unless user_signed_in?
  end
end
