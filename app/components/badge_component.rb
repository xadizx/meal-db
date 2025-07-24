class BadgeComponent < ViewComponent::Base
  THEMES = {
    gray: {bg: "bg-gray-100", text: "text-gray-600"},
    red: {bg: "bg-red-100", text: "text-red-700"},
    yellow: {bg: "bg-yellow-100", text: "text-yellow-800"},
    green: {bg: "bg-green-100", text: "text-green-700"},
    blue: {bg: "bg-blue-100", text: "text-blue-700"},
    indigo: {bg: "bg-indigo-100", text: "text-indigo-700"},
    purple: {bg: "bg-purple-100", text: "text-purple-700"},
    pink: {bg: "bg-pink-100", text: "text-pink-700"}
  }.freeze

  def initialize(text:, theme: :gray)
    @text = text
    @theme = theme.to_sym
  end

  private

  attr_reader :text, :theme

  def bg_class
    THEMES[theme][:bg] || THEMES[:gray][:bg]
  end

  def text_class
    THEMES[theme][:text] || THEMES[:gray][:text]
  end
end
