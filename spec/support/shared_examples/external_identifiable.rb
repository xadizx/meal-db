RSpec.shared_examples "external_identifiable" do
  let(:model) { described_class }
  let(:factory_name) { model.name.underscore.to_sym }

  describe "class methods" do
    describe ".find_by_external_id" do
      context "when the model exists" do
        it "returns the model with the given external id" do
          record = create(factory_name)
          expect(model.find_by_external_id(record.external_id)).to eq(record)
        end
      end

      context "when the model does not exist" do
        it "returns nil" do
          expect(model.find_by_external_id("non-existent-id")).to be_nil
        end
      end
    end

    describe ".find_by_external_id!" do
      context "when the model exists" do
        it "returns the model with the given external id" do
          record = create(factory_name)
          expect(model.find_by_external_id!(record.external_id)).to eq(record)
        end
      end

      context "when the model does not exist" do
        it "raises an error" do
          expect { model.find_by_external_id!("non-existent-id") }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_uniqueness_of(:external_id) }
  end
end
