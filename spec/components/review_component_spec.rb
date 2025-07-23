require "rails_helper"

RSpec.describe ReviewComponent, type: :component do
  it "renders review with user, rating, and comment" do
    render_inline(described_class.new(author: "Alice", rating: 4, comment: "Nice!", review_id: 1))
    expect(page).to have_content("Alice")
    expect(page).to have_content("Nice!")
    expect(page).to have_css(".text-yellow-400", count: 4)
    expect(page).to have_css(".text-gray-200", count: 1)
  end

  it "renders remove button if removable" do
    render_inline(described_class.new(author: "Bob", rating: 2, comment: "Not great", review_id: 1, removable: true))
    expect(page).to have_css("a.text-red-600")
    expect(page).to have_css("svg.w-4.h-4")
  end

  it "yields block for custom remove action" do
    rendered = render_inline(described_class.new(author: "Charlie", rating: 5, comment: "Perfect", review_id: 1, removable: true)) do
      "<span class='custom-remove'>Remove</span>".html_safe
    end
    expect(rendered.to_html).to include("custom-remove")
  end
end
