require "rails_helper"

RSpec.describe FlashMessageComponent, type: :component do
  let(:rendered) { render_inline(component) }

  describe "with success type" do
    let(:component) { described_class.new(type: :success, message: "Operation completed successfully") }

    it "renders with correct styling" do
      expect(rendered.css("div").first["class"]).to include("bg-green-50", "border-green-200")
      expect(rendered.css("svg").first["class"]).to include("text-green-400")
      expect(rendered.css("p").first["class"]).to include("text-green-800")
    end

    it "displays the message" do
      expect(rendered.text).to include("Operation completed successfully")
    end

    it "includes dismiss button by default" do
      expect(rendered.css("button").first).to be_present
      expect(rendered.css("button").first["data-action"]).to eq("click->flash#dismiss")
    end

    it "includes stimulus controller data" do
      expect(rendered.css("div").first["data-controller"]).to eq("flash")
    end
  end

  describe "with alert type" do
    let(:component) { described_class.new(type: :alert, message: "Something went wrong") }

    it "renders with correct styling" do
      expect(rendered.css("div").first["class"]).to include("bg-red-50", "border-red-200")
      expect(rendered.css("svg").first["class"]).to include("text-red-400")
      expect(rendered.css("p").first["class"]).to include("text-red-800")
    end

    it "displays the message" do
      expect(rendered.text).to include("Something went wrong")
    end
  end

  describe "with warning type" do
    let(:component) { described_class.new(type: :warning, message: "Please be careful") }

    it "renders with correct styling" do
      expect(rendered.css("div").first["class"]).to include("bg-yellow-50", "border-yellow-200")
      expect(rendered.css("svg").first["class"]).to include("text-yellow-400")
      expect(rendered.css("p").first["class"]).to include("text-yellow-800")
    end
  end

  describe "with notice type" do
    let(:component) { described_class.new(type: :notice, message: "Information updated") }

    it "renders with correct styling" do
      expect(rendered.css("div").first["class"]).to include("bg-blue-50", "border-blue-200")
      expect(rendered.css("svg").first["class"]).to include("text-blue-400")
      expect(rendered.css("p").first["class"]).to include("text-blue-800")
    end
  end

  describe "with multiple messages" do
    let(:component) do
      described_class.new(
        type: :alert,
        messages: ["Password is too short", "Email is invalid", "Name can't be blank"]
      )
    end

    it "renders as a list" do
      expect(rendered.css("ul").first).to be_present
      expect(rendered.css("li").count).to eq(3)
    end

    it "displays default title for multiple errors" do
      expect(rendered.text).to include("There were 3 errors with your submission")
    end

    it "displays all messages" do
      expect(rendered.text).to include("Password is too short")
      expect(rendered.text).to include("Email is invalid")
      expect(rendered.text).to include("Name can't be blank")
    end
  end

  describe "with custom title" do
    let(:component) do
      described_class.new(
        type: :alert,
        messages: ["Field 1 error", "Field 2 error"],
        title: "Custom Error Title"
      )
    end

    it "displays custom title" do
      expect(rendered.text).to include("Custom Error Title")
      expect(rendered.text).not_to include("There were 2 errors")
    end
  end

  describe "validation" do
    it "raises error for invalid type" do
      expect {
        described_class.new(type: :invalid, message: "test")
      }.to raise_error(ArgumentError, "Invalid flash type: invalid")
    end

    it "raises error when no message or messages provided" do
      expect {
        described_class.new(type: :success)
      }.to raise_error(ArgumentError, "Must provide either message or messages")
    end
  end

  describe "default titles" do
    it "returns correct default title for success" do
      component = described_class.new(type: :success, message: "test")
      expect(component.send(:default_title)).to eq("Success")
    end

    it "returns correct default title for single error" do
      component = described_class.new(type: :alert, message: "test")
      expect(component.send(:default_title)).to eq("Error")
    end

    it "returns correct default title for multiple errors" do
      component = described_class.new(type: :alert, messages: ["error1", "error2"])
      expect(component.send(:default_title)).to eq("There were 2 errors with your submission")
    end

    it "returns correct default title for warning" do
      component = described_class.new(type: :warning, message: "test")
      expect(component.send(:default_title)).to eq("Warning")
    end

    it "returns correct default title for notice" do
      component = described_class.new(type: :notice, message: "test")
      expect(component.send(:default_title)).to eq("Notice")
    end
  end
end
