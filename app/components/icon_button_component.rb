class IconButtonComponent < ViewComponent::Base
  THEMES = {
    gray: {bg: "bg-gray-100", text: "text-gray-900", hover: "hover:bg-gray-200"},
    yellow: {bg: "bg-yellow-100", text: "text-yellow-800", hover: "hover:bg-yellow-200"},
    indigo: {bg: "bg-indigo-100", text: "text-indigo-700", hover: "hover:bg-indigo-200"},
    red: {bg: "bg-red-100", text: "text-red-700", hover: "hover:bg-red-200"},
    green: {bg: "bg-green-100", text: "text-green-700", hover: "hover:bg-green-200"}
  }.freeze

  def initialize(icon_svg:, theme: :gray, text: nil, action: "#", method: :get, turbo: true, data: {})
    @icon_svg = icon_svg
    @theme = theme.to_sym
    @text = text
    @action = action
    @method = method.to_sym
    @turbo = turbo
    @data = data
  end

  def bg_class
    THEMES[@theme][:bg] || THEMES[:gray][:bg]
  end

  def text_class
    THEMES[@theme][:text] || THEMES[:gray][:text]
  end

  def hover_class
    THEMES[@theme][:hover] || THEMES[:gray][:hover]
  end

  def turbo_data
    (@data || {}).merge(turbo: @turbo)
  end
end
