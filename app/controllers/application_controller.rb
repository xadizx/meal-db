class ApplicationController < ActionController::Base
  respond_to :html, :turbo_stream

  private

  def flash_turbo_stream(type:, message: nil, messages: nil, **options)
    turbo_stream.update(
      "flash_messages",
      partial: "shared/flash_container",
      locals: {
        flash_component: FlashMessageComponent.new(
          type: type,
          message: message,
          messages: messages,
          **options
        )
      }
    )
  end

  def after_sign_in_path_for(resource)
    meals_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
