class ButtonComponent < ViewComponent::Base
  THEMES = {
    primary: {bg: "bg-indigo-600", text: "text-white", hover: "hover:bg-indigo-500"},
    gray: {bg: "bg-gray-100", text: "text-gray-900", hover: "hover:bg-gray-200"},
    yellow: {bg: "bg-yellow-100", text: "text-yellow-800", hover: "hover:bg-yellow-200"},
    indigo: {bg: "bg-indigo-100", text: "text-indigo-700", hover: "hover:bg-indigo-200"},
    red: {bg: "bg-red-100", text: "text-red-700", hover: "hover:bg-red-200"},
    green: {bg: "bg-green-100", text: "text-green-700", hover: "hover:bg-green-200"}
  }.freeze

  def initialize(icon_svg: nil, theme: :gray, text: nil, action: "#", method: :get, turbo: true, data: {}, button_type: :auto)
    @icon_svg = icon_svg
    @theme = theme.to_sym
    @text = text
    @action = action
    @method = method.to_sym
    @turbo = turbo
    @data = data
    @button_type = button_type.to_sym
  end

  def classes
    "flex w-full justify-center rounded-md px-3 py-1.5 text-sm/6 font-semibold shadow-sm focus-visible:outline-2 focus-visible:outline-offset-2 #{bg_class} #{text_class} #{hover_class} transition"
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

  def render_as_submit?
    @button_type == :submit
  end

  def render_as_form_button?
    @button_type == :form || (@button_type == :auto && [:post, :put, :delete].include?(@method))
  end

  def render_as_link?
    @button_type == :link || (@button_type == :auto && @method == :get)
  end
end
