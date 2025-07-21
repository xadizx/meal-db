require "rails_helper"

RSpec.describe Meal, type: :model do
  subject { build(:meal) }

  describe "associations" do
    it { is_expected.to belong_to(:category).inverse_of(:meals) }
    it { is_expected.to have_many(:meal_ingredients).dependent(:destroy).inverse_of(:meal) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_uniqueness_of(:external_id) }
  end
end
