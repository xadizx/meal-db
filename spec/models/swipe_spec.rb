require "rails_helper"

RSpec.describe Swipe, type: :model do
  subject { build(:swipe) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:meal) }
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:preference).with_values({disliked: 0, liked: 1}) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:preference) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:meal_id) }
  end
end
