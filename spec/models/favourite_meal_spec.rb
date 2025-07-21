require "rails_helper"

RSpec.describe FavouriteMeal, type: :model do
  subject { build(:favourite_meal) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:meal) }
  end

  describe "validations" do
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:meal_id).with_message("has already favourited this meal") }
  end
end
