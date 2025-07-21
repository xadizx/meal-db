require "rails_helper"

RSpec.describe Categories::Importer do
  describe "#call" do
    subject { described_class.call }

    context "when there are no categories" do
      it "imports all categories from the MealDB API" do
        VCR.use_cassette("categories_index") do
          expect { subject }.to change(Category, :count).by(14)
        end
      end
    end

    context "when there are categories" do
      let!(:existing_category) { create(:category, external_id: "1", name: "Already imported") }

      it "does not import categories that already exist" do
        VCR.use_cassette("categories_index") do
          expect { subject }.to change(Category, :count).by(13)
        end
      end

      it "updates the existing category" do
        VCR.use_cassette("categories_index") do
          expect { subject }.to change { existing_category.reload.name }.to("Beef")
        end
      end
    end
  end
end
