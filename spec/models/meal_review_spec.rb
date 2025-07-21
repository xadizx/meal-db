require "rails_helper"

RSpec.describe MealReview, type: :model do
  subject { build(:meal_review) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:meal) }
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:rating).only_integer.is_greater_than(0).is_less_than(6) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:meal_id).with_message("has already reviewed this meal") }
  end
end
