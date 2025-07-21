require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "associations" do
    it { is_expected.to have_many(:meal_reviews).dependent(:destroy) }
    it { is_expected.to have_many(:rated_meals).through(:meal_reviews).source(:meal) }
    it { is_expected.to have_many(:favourite_meals).dependent(:destroy) }
    it { is_expected.to have_many(:favourited_meals).through(:favourite_meals).source(:meal) }
  end
end
