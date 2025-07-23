require "rails_helper"

RSpec.describe EmptyStateComponent, type: :component do
  it "renders with required parameters" do
    component = EmptyStateComponent.new(
      title: "No items found",
      primary_action_text: "Add Item",
      primary_action_path: "/items/new"
    )

    render_inline(component)

    expect(page).to have_text("No items found")
    expect(page).to have_link(href: "/items/new")
  end

  it "renders with secondary action when provided" do
    component = EmptyStateComponent.new(
      title: "No items found",
      primary_action_text: "Add Item",
      primary_action_path: "/items/new",
      secondary_action_text: "Browse catalog",
      secondary_action_path: "/catalog"
    )

    render_inline(component)

    expect(page).to have_text("No items found")
    expect(page).to have_link(href: "/items/new")
    expect(page).to have_link("Browse catalog", href: "/catalog")
  end

  it "renders without secondary action when not provided" do
    component = EmptyStateComponent.new(
      title: "No items found",
      primary_action_text: "Add Item",
      primary_action_path: "/items/new"
    )

    render_inline(component)

    expect(page).to have_text("No items found")
    expect(page).to have_link(href: "/items/new")
    expect(page).not_to have_css("a.mt-4")
  end

  it "renders with custom icon when provided" do
    custom_icon = '<svg class="custom-icon"><path d="test"/></svg>'

    component = EmptyStateComponent.new(
      title: "No items found",
      primary_action_text: "Add Item",
      primary_action_path: "/items/new",
      icon_svg: custom_icon
    )

    render_inline(component)

    expect(page).to have_css("svg.custom-icon")
  end

  it "renders with default icon when none provided" do
    component = EmptyStateComponent.new(
      title: "No items found",
      primary_action_text: "Add Item",
      primary_action_path: "/items/new"
    )

    render_inline(component)

    expect(page).to have_css("svg")
    # The SVG should contain viewBox attribute
    expect(page.native.to_html.downcase).to include('viewbox="0 0 48 48"')
  end

  it "has proper CSS classes and structure" do
    component = EmptyStateComponent.new(
      title: "No items found",
      primary_action_text: "Add Item",
      primary_action_path: "/items/new"
    )

    render_inline(component)

    expect(page).to have_css("div.flex.flex-col.items-center.justify-center.py-12")
    expect(page).to have_css("a.relative.block.w-full.rounded-lg.border-2.border-dashed")
    expect(page).to have_css("span.mt-2.block.text-sm.font-semibold.text-gray-900")
  end
end
