class ButtonComponent < ViewComponent::Base
  THEMES = {
    primary: "bg-indigo-600 text-white hover:bg-indigo-700",
    primary_outline: "bg-transparent outline outline-2 outline-indigo-600 text-indigo-600 hover:bg-indigo-100",
    secondary: "bg-gray-100 text-gray-900 hover:bg-gray-200"
  }.freeze

  def initialize(theme: :primary, action: "#", method: :get, turbo: true, data: {}, button_type: :auto, classes: "")
    @theme = theme.to_sym
    @action = action
    @method = method.to_sym
    @turbo = turbo
    @data = data
    @button_type = button_type.to_sym
    @classes = classes
  end

  private

  attr_reader :theme, :action, :method, :turbo, :data, :button_type, :classes

  def base_classes
    "flex justify-center rounded-md px-3 py-1.5 text-sm/6 font-semibold shadow-sm focus-visible:outline-2 focus-visible:outline-offset-2  transition cursor-pointer"
  end

  def button_classes
    [base_classes, THEMES[theme], classes].compact.join(" ")
  end

  def turbo_data
    (data || {}).merge(turbo: turbo)
  end

  def render_as_submit?
    button_type == :submit
  end

  def render_as_form_button?
    button_type == :form
  end

  def render_as_link?
    button_type == :link
  end

  def ensure_theme_exists
    raise "Theme #{theme} does not exist" unless THEMES.key?(theme)
  end
end
