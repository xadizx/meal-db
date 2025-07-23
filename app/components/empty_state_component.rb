class EmptyStateComponent < ViewComponent::Base
  def initialize(title:, primary_action_text:, primary_action_path:, secondary_action_text: nil, secondary_action_path: nil, icon_svg: nil)
    @title = title
    @primary_action_text = primary_action_text
    @primary_action_path = primary_action_path
    @secondary_action_text = secondary_action_text
    @secondary_action_path = secondary_action_path
    @icon_svg = icon_svg || default_icon_svg
  end

  private

  def default_icon_svg
    <<~SVG
      <svg viewBox="0 0 48 48" fill="none" stroke="currentColor" aria-hidden="true" class="mx-auto size-12 text-gray-400">
        <path d="M8 14v20c0 4.418 7.163 8 16 8 1.381 0 2.721-.087 4-.252M8 14c0 4.418 7.163 8 16 8s16-3.582 16-8M8 14c0-4.418 7.163-8 16-8s16 3.582 16 8m0 0v14m0-4c0 4.418-7.163 8-16 8S8 28.418 8 24m32 10v6m0 0v6m0-6h6m-6 0h-6" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
      </svg>
    SVG
  end
end
