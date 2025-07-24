require "rails_helper"

RSpec.describe MealThumbnailComponent, type: :component do
  let(:meal_card) do
    MealCard.new(
      external_id: 123,
      thumbnail_image_url: "http://example.com/image.jpg",
      category_name: "Dessert",
      name: "Chocolate Cake"
    )
  end

  it "renders the meal thumbnail with correct data" do
    render_inline(described_class.new(meal_card: meal_card))

    expect(page).to have_link(href: "/meals/123")
    expect(page).to have_css("img[src='http://example.com/image.jpg']")
    expect(page).to have_content("Dessert")
    expect(page).to have_content("Chocolate Cake")
  end
end
