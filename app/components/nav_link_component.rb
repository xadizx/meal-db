class NavLinkComponent < ViewComponent::Base
  ALLOWED_VARIANTS = [:main, :mobile].freeze

  def initialize(path:, text:, variant: :main)
    @path = path
    @text = text
    @variant = variant

    unless ALLOWED_VARIANTS.include?(variant)
      raise ArgumentError, "Unknown variant: #{variant}. Use :main or :mobile"
    end
  end

  private

  attr_reader :path, :text, :variant

  def link_classes
    base_classes = case variant
    when :main
      main_nav_classes
    when :mobile
      mobile_nav_classes
    end

    current_page?(path) ? base_classes[:active] : base_classes[:inactive]
  end

  def main_nav_classes
    {
      active: "border-indigo-500 text-gray-900 inline-flex items-center border-b-2 px-1 pt-1 text-sm font-medium",
      inactive: "border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700 inline-flex items-center border-b-2 px-1 pt-1 text-sm font-medium"
    }
  end

  def mobile_nav_classes
    {
      active: "border-indigo-500 bg-indigo-50 text-indigo-700 block border-l-4 py-2 pl-3 pr-4 text-base font-medium",
      inactive: "border-transparent text-gray-600 hover:border-gray-300 hover:bg-gray-50 hover:text-gray-800 block border-l-4 py-2 pl-3 pr-4 text-base font-medium"
    }
  end
end
