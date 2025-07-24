require "rails_helper"

RSpec.describe MealDecorator do
  let(:meal) { build(:meal, external_id: 100, name: "Test Meal", thumbnail_image_url: "https://example.com/thumbnail.jpg") }
  let(:decorated_meal) { meal.decorate }

  describe "#to_card" do
    it "returns a MealCard object" do
      expect(decorated_meal.to_card).to be_a(MealCard)
    end

    it "returns a MealCard object with the correct attributes" do
      expect(decorated_meal.to_card).to have_attributes(
        external_id: 100,
        name: "Test Meal",
        thumbnail_image_url: "https://example.com/thumbnail.jpg"
      )
    end
  end
end
