module FlashMessages
  extend ActiveSupport::Concern

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
end
