module ApplicationHelper
  def render_flash_messages
    return "" if flash.empty?

    content = ""

    flash.each do |type, message|
      content += render(FlashMessageComponent.new(type: type.to_sym, message: message))
    end

    content.html_safe
  end
end
