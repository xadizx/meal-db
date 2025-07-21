require "rails_helper"

RSpec.describe AreaGetter do
  describe "#call" do
    subject { described_class.call }

    it "returns a list of area names from the MealDB API", :vcr do
      VCR.use_cassette("areas_getter") do
        expect(subject).to be_an(Array)
        expect(subject).to all(be_a(String))
        expect(subject.size).to eq(29)
      end
    end

    it "caches the result" do
      # TODO: Add later
    end
  end
end
