require "rails_helper"

RSpec.describe BadgeComponent, type: :component do
  it "renders with default theme" do
    render_inline(described_class.new(text: "Default"))
    expect(page).to have_css(".bg-gray-100.text-gray-600", text: "Default")
  end

  it "renders with red theme" do
    render_inline(described_class.new(text: "Danger", theme: :red))
    expect(page).to have_css(".bg-red-100.text-red-700", text: "Danger")
  end

  it "renders with blue theme" do
    render_inline(described_class.new(text: "Info", theme: :blue))
    expect(page).to have_css(".bg-blue-100.text-blue-700", text: "Info")
  end
end
