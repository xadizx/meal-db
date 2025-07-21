require "rails_helper"

RSpec.describe Category, type: :model do
  subject { build(:category) }

  describe "associations" do
    it { is_expected.to have_many(:meals).dependent(:nullify).inverse_of(:category) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_uniqueness_of(:external_id) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:thumbnail_url) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe "scopes" do
    describe ".ordered" do
      it "returns categories ordered by name" do
        create(:category, name: "B")
        create(:category, name: "A")
        expect(Category.ordered.pluck(:name)).to eq(["A", "B"])
      end
    end
  end
end
