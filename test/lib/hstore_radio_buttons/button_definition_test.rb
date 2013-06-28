require_relative '../../test_helper.rb'

describe HstoreRadioButtons::ButtonDefinition do
  describe "#options" do
    before :each do
      @it = HstoreRadioButtons::ButtonDefinition.new
    end

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
