require "rails_helper"

RSpec.describe Meal, type: :model do
  subject { create(:meal) }

  describe "associations" do
    it { is_expected.to belong_to(:category) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_uniqueness_of(:external_id) }
  end
end
