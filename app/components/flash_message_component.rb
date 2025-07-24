class FlashMessageComponent < ViewComponent::Base
  TYPES = {
    success: {
      container_classes: "bg-green-50 border-green-200",
      text_color: "!text-green-800",
      icon_color: "text-green-400",
      button_classes: "text-green-500 hover:bg-green-100 focus:ring-green-600 focus:ring-offset-green-50",
      icon_path: "M10 18a8 8 0 1 0 0-16 8 8 0 0 0 0 16Zm3.857-9.809a.75.75 0 0 0-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 1 0-1.06 1.061l2.5 2.5a.75.75 0 0 0 1.137-.089l4-5.5Z"
    },
    alert: {
      container_classes: "bg-red-50 border-red-200",
      text_color: "!text-red-800",
      icon_color: "text-red-400",
      button_classes: "text-red-500 hover:bg-red-100 focus:ring-red-600 focus:ring-offset-red-50",
      icon_path: "M10 18a8 8 0 1 0 0-16 8 8 0 0 0 0 16ZM8.28 7.22a.75.75 0 0 0-1.06 1.06L8.94 10l-1.72 1.72a.75.75 0 1 0 1.06 1.06L10 11.06l1.72 1.72a.75.75 0 1 0 1.06-1.06L11.06 10l1.72-1.72a.75.75 0 0 0-1.06-1.06L10 8.94 8.28 7.22Z"
    },
    warning: {
      container_classes: "bg-yellow-50 border-yellow-200",
      text_color: "!text-yellow-800",
      icon_color: "text-yellow-400",
      button_classes: "text-yellow-500 hover:bg-yellow-100 focus:ring-yellow-600 focus:ring-offset-yellow-50",
      icon_path: "M8.485 2.495c.673-1.167 2.357-1.167 3.03 0l6.28 10.875c.673 1.167-.17 2.625-1.516 2.625H3.72c-1.347 0-2.189-1.458-1.515-2.625L8.485 2.495ZM10 5a.75.75 0 0 1 .75.75v3.5a.75.75 0 0 1-1.5 0v-3.5A.75.75 0 0 1 10 5Zm0 9a1 1 0 1 0 0-2 1 1 0 0 0 0 2Z"
    },
    notice: {
      container_classes: "bg-blue-50 border-blue-200",
      text_color: "!text-blue-800",
      icon_color: "text-blue-400",
      button_classes: "text-blue-500 hover:bg-blue-100 focus:ring-blue-600 focus:ring-offset-blue-50",
      icon_path: "M18 10a8 8 0 1 1-16 0 8 8 0 0 1 16 0Zm-7-4a1 1 0 1 1-2 0 1 1 0 0 1 2 0ZM9 9a.75.75 0 0 0 0 1.5h.253a.25.25 0 0 1 .244.304l-.459 2.066A1.75 1.75 0 0 0 10.747 15H11a.75.75 0 0 0 0-1.5h-.253a.25.25 0 0 1-.244-.304l.459-2.066A1.75 1.75 0 0 0 9.253 9H9Z"
    }
  }.freeze

  def initialize(type:, message: nil, title: nil, messages: nil)
    @type = type.to_sym
    @message = message
    @title = title
    @messages = messages

    raise ArgumentError, "Invalid flash type: #{type}" unless TYPES.key?(type)
    raise ArgumentError, "Must provide either message or messages" if message.nil? && messages.nil?
  end

  private

  attr_reader :type, :message, :title, :messages

  def config
    TYPES[type]
  end

  def has_multiple_messages?
    messages.present? && messages.is_a?(Array) && messages.length > 1
  end

  def display_title
    title || default_title
  end

  def default_title
    case type
    when :success
      "Success"
    when :alert
      has_multiple_messages? ? "There were #{messages.length} errors with your submission" : "Error"
    when :warning
      "Warning"
    when :notice
      "Notice"
    end
  end
end
