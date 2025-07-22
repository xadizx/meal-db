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
    it { is_expected.to validate_presence_of(:thumbnail_image_url) }
    it { is_expected.to validate_presence_of(:instructions) }
    it { is_expected.to validate_presence_of(:area) }
  end

  describe "#average_rating" do
    let(:meal) { create(:meal) }

    context "when there are no reviews" do
      it "returns 0.0" do
        expect(meal.average_rating).to eq(0)
      end
    end

    context "when there are reviews" do
      before do
        create(:meal_review, meal: meal, rating: 4)
        create(:meal_review, meal: meal, rating: 5)
        create(:meal_review, meal: meal, rating: 3)
      end

      it "returns the average rating rounded to 1 decimal place" do
        expect(meal.average_rating).to eq(4.0)
      end
    end

    context "when the average has multiple decimal places" do
      before do
        create(:meal_review, meal: meal, rating: 4)
        create(:meal_review, meal: meal, rating: 3)
        create(:meal_review, meal: meal, rating: 3)
      end

      it "rounds to 1 decimal place" do
        expect(meal.average_rating).to eq(3.3)
      end
    end
  end

  describe "#review_count" do
    let(:meal) { create(:meal) }

    context "when there are no reviews" do
      it "returns 0" do
        expect(meal.review_count).to eq(0)
      end
    end

    context "when there are reviews" do
      before do
        create_list(:meal_review, 3, meal: meal)
      end

      it "returns the correct count" do
        expect(meal.review_count).to eq(3)
      end
    end
  end

  describe "#main_ingredient" do
    let(:meal) { create(:meal) }

    context "when there are no ingredients" do
      it "returns 'Not specified'" do
        expect(meal.main_ingredient).to eq("Not specified")
      end
    end

    context "when there are ingredients" do
      before do
        create(:meal_ingredient, meal: meal, name: "Chicken")
        create(:meal_ingredient, meal: meal, name: "Rice")
      end

      it "returns the first ingredient name" do
        expect(meal.main_ingredient).to eq("Chicken")
      end
    end
  end
end
