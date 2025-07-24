require "rails_helper"

RSpec.describe ButtonComponent, type: :component do
  it "renders as a link with content block" do
    render_inline(described_class.new(action: "/foo", method: :get, theme: :primary)) { "Click me" }
    expect(page).to have_link("Click me", href: "/foo")
    expect(page).to have_css(".bg-indigo-600.text-white")
  end

  it "renders as a form button (button_to) with content block" do
    render_inline(described_class.new(action: "/bar", method: :post, theme: :secondary, button_type: :form)) { "Submit" }
    expect(page).to have_selector("form[action='/bar'][method='post']")
    expect(page).to have_button("Submit")
    expect(page).to have_css(".bg-gray-100.text-gray-900")
  end

  it "renders as a submit button with content block" do
    render_inline(described_class.new(theme: :primary_outline, button_type: :submit)) { "Save" }
    expect(page).to have_selector("button[type='submit']", text: "Save")
    expect(page).to have_css(".bg-transparent.outline-indigo-600.text-indigo-600")
  end

  it "sets data-turbo attribute correctly for link" do
    render_inline(described_class.new(action: "/turbo", turbo: false)) { "Turbo Link" }
    expect(page).to have_css("a[data-turbo='false']")
    render_inline(described_class.new(action: "/turbo", turbo: true)) { "Turbo Link" }
    expect(page).to have_css("a[data-turbo='true']")
  end

  it "sets data-turbo attribute correctly for form button" do
    render_inline(described_class.new(action: "/form", method: :post, turbo: false, button_type: :form)) { "Form Btn" }
    expect(page).to have_css("form button[data-turbo='false']")
    render_inline(described_class.new(action: "/form", method: :post, turbo: true, button_type: :form)) { "Form Btn" }
    expect(page).to have_css("form button[data-turbo='true']")
  end

  it "sets data-turbo attribute correctly for submit button" do
    render_inline(described_class.new(turbo: false, button_type: :submit)) { "Submit Btn" }
    expect(page).to have_css("button[type='submit'][data-turbo='false']")
    render_inline(described_class.new(turbo: true, button_type: :submit)) { "Submit Btn" }
    expect(page).to have_css("button[type='submit'][data-turbo='true']")
  end

  it "applies extra classes if provided" do
    render_inline(described_class.new(classes: "custom-class")) { "With Extra" }
    expect(page).to have_css(".custom-class")
  end
end
