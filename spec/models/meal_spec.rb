require "rails_helper"

RSpec.describe Meal, type: :model do
  subject { build(:meal) }

  it_behaves_like "external_identifiable"

  describe "associations" do
    it { is_expected.to belong_to(:category).inverse_of(:meals) }
    it { is_expected.to have_many(:meal_ingredients).dependent(:destroy).inverse_of(:meal) }
    it { is_expected.to have_many(:meal_reviews).dependent(:destroy) }
    it { is_expected.to have_many(:favourite_meals).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:thumbnail_url) }
    it { is_expected.to validate_presence_of(:instructions) }
    it { is_expected.to validate_presence_of(:area) }
  end
end
