class ApplicationController < ActionController::Base
  respond_to :html, :turbo_stream

  private

  def after_sign_in_path_for(resource)
    meals_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
