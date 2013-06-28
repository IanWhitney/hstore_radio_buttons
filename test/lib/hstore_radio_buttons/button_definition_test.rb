require_relative '../../test_helper.rb'

describe HstoreRadioButtons::ButtonDefinition do
  before :each do
    @it = HstoreRadioButtons::ButtonDefinition.new
  end

  describe "#name" do
    it "returns a string when set to a string" do
      @it.name = "string"
      @it.name.must_equal "string"
    end

    it "returns a string when set to a symbol" do
      @it.name = :symbol
      @it.name.must_equal "symbol"
    end
  end

  describe "#options" do
    it "turns a single option into an array" do
      @it.options = 1
      @it.options.must_equal [1]
    end

    it "turns a null options into an array" do
      @it.options = nil
      @it.options.must_equal []
    end
  end
end
