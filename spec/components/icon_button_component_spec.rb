require "rails_helper"

RSpec.describe IconButtonComponent, type: :component do
  let(:icon_svg) { '<svg class="w-5 h-5"></svg>' }

  it "renders as a link with text and icon" do
    render_inline(described_class.new(icon_svg: icon_svg, text: "Click me", action: "/foo", method: :get, theme: :yellow))
    expect(page).to have_link("Click me", href: "/foo")
    expect(page).to have_css(".bg-yellow-100.text-yellow-800")
    expect(page).to have_css("svg.w-5.h-5")
  end

  it "renders as a button for post method" do
    render_inline(described_class.new(icon_svg: icon_svg, text: "Submit", action: "/bar", method: :post, theme: :indigo))
    expect(page).to have_button("Submit")
    expect(page).to have_css(".bg-indigo-100.text-indigo-700")
    expect(page).to have_css("svg.w-5.h-5")
  end

  it "renders with icon only" do
    render_inline(described_class.new(icon_svg: icon_svg, action: "/icon", method: :get, theme: :red))
    expect(page).to have_link(href: "/icon")
    expect(page).to have_css(".bg-red-100.text-red-700")
    expect(page).to have_css("svg.w-5.h-5")
  end

  it "passes turbo true to link" do
    render_inline(described_class.new(icon_svg: icon_svg, text: "Turbo", action: "/turbo", method: :get, turbo: true))
    expect(page).to have_css("a[data-turbo='true']")
  end

  it "passes turbo false to link" do
    render_inline(described_class.new(icon_svg: icon_svg, text: "No Turbo", action: "/no_turbo", method: :get, turbo: false))
    expect(page).to have_css("a[data-turbo='false']")
  end

  it "passes turbo true to button" do
    render_inline(described_class.new(icon_svg: icon_svg, text: "TurboBtn", action: "/turbo_btn", method: :post, turbo: true))
    expect(page).to have_css("form button[data-turbo='true']")
  end

  it "passes turbo false to button" do
    render_inline(described_class.new(icon_svg: icon_svg, text: "NoTurboBtn", action: "/no_turbo_btn", method: :post, turbo: false))
    expect(page).to have_css("form button[data-turbo='false']")
  end
end
