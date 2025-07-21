require "rails_helper"

RSpec.describe MealIngredient, type: :model do
  subject { build(:meal_ingredient) }

  describe "associations" do
    it { is_expected.to belong_to(:meal).inverse_of(:meal_ingredients) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:measurement) }
  end
end
