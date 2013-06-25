require_relative '../../test_helper.rb'

describe HstoreRadioButtons::ButtonOptions do
  describe "#name" do
    it "replaces spaces in a name with underscores" do
      it = HstoreRadioButtons::ButtonOptions.new('test name', nil)
      it.name.must_equal 'test_name'
    end

    it "downcases the name" do
      it = HstoreRadioButtons::ButtonOptions.new('Test', nil)
      it.name.must_equal 'test'
    end
  end

  describe "#options" do
    it "turns a single option into an array" do
      it = HstoreRadioButtons::ButtonOptions.new('test', 1)
      it.options.must_equal [1]
    end

    it "turns a null options into an array" do
      it = HstoreRadioButtons::ButtonOptions.new('test', nil)
      it.options.must_equal []
    end
  end
end
