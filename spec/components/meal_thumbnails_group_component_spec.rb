require "rails_helper"

RSpec.describe MealThumbnailsGroupComponent, type: :component do
  let(:meal_card1) do
    MealCard.new(
      external_id: 123,
      thumbnail_image_url: "http://example.com/image.jpg",
      category_name: "Dessert",
      name: "Chocolate Cake"
    )
  end

  let(:meal_card2) do
    MealCard.new(
      external_id: 456,
      thumbnail_image_url: "http://example.com/image2.jpg",
      category_name: "Main Course",
      name: "Spaghetti Carbonara"
    )
  end

  context "when meal_cards are present" do
    it "renders the grid of meal thumbnails" do
      render_inline(described_class.new(meal_cards: [meal_card1, meal_card2]))

      expect(page).to have_content("Chocolate Cake")
      expect(page).to have_content("Main Course")
      expect(page).to have_css("img[src='http://example.com/image.jpg']")
      expect(page).to have_css("img[src='http://example.com/image2.jpg']")
      expect(page).to have_link(href: "/meals/123")
      expect(page).to have_link(href: "/meals/456")
    end
  end

  context "when meal_cards is empty" do
    it "renders the empty state with browse and random meal links" do
      render_inline(described_class.new(meal_cards: []))

      expect(page).to have_content("No favourite meals yet. Start browsing to add some!")
      expect(page).to have_link(href: Rails.application.routes.url_helpers.meals_path)
      expect(page).to have_link("Or check a random meal", href: Rails.application.routes.url_helpers.random_meals_path)
    end
  end
end
