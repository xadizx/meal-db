require "rails_helper"

RSpec.describe NavLinkComponent, type: :component do
  let(:path) { "/meals" }
  let(:text) { "Meals" }

  describe "main navigation variant" do
    let(:component) { described_class.new(path: path, text: text, variant: :main) }

    context "when on current page" do
      before do
        allow(component).to receive(:current_page?).with(path).and_return(true)
      end

      it "renders active main nav classes" do
        render_inline(component)
        expect(page).to have_link(text, href: path)
        expect(page).to have_css("a.border-indigo-500.text-gray-900")
      end
    end

    context "when not on current page" do
      before do
        allow(component).to receive(:current_page?).with(path).and_return(false)
      end

      it "renders inactive main nav classes" do
        render_inline(component)
        expect(page).to have_link(text, href: path)
        expect(page).to have_css("a.border-transparent.text-gray-500")
      end
    end
  end

  describe "mobile navigation variant" do
    let(:component) { described_class.new(path: path, text: text, variant: :mobile) }

    context "when on current page" do
      before do
        allow(component).to receive(:current_page?).with(path).and_return(true)
      end

      it "renders active mobile nav classes" do
        render_inline(component)
        expect(page).to have_link(text, href: path)
        expect(page).to have_css("a.border-indigo-500.bg-indigo-50.text-indigo-700")
      end
    end

    context "when not on current page" do
      before do
        allow(component).to receive(:current_page?).with(path).and_return(false)
      end

      it "renders inactive mobile nav classes" do
        render_inline(component)
        expect(page).to have_link(text, href: path)
        expect(page).to have_css("a.border-transparent.text-gray-600")
      end
    end
  end

  describe "default variant" do
    let(:component) { described_class.new(path: path, text: text) }

    it "defaults to main variant" do
      allow(component).to receive(:current_page?).with(path).and_return(false)
      render_inline(component)
      expect(page).to have_css("a.inline-flex.items-center")
    end
  end

  describe "invalid variant" do
    it "raises an error for unknown variant" do
      expect {
        described_class.new(path: path, text: text, variant: :invalid)
      }.to raise_error(ArgumentError, "Unknown variant: invalid. Use :main or :mobile")
    end
  end
end
