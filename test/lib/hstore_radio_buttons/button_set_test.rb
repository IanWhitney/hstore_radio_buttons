require_relative '../../test_helper.rb'

describe HstoreRadioButtons::ButtonSet do
  describe '#initialize' do
    before :each do
      @it = Person.new
      @button_definition = OpenStruct.new({name: 'test name', options: [1,2,3]})
      HstoreRadioButtons::ButtonSet.new(@button_definition,@it.class)
      @method_names = HstoreRadioButtons::MethodNamer.new(@button_definition.name)
    end

    it 'adds getters and setters for the button sets defined in the config file' do
      @it.must_respond_to @method_names.getter
      @it.must_respond_to @method_names.setter
    end

    it "adds a method that returns the button set's options" do
      @it.must_respond_to @method_names.options
      @it.send(@method_names.options).must_equal @button_definition.options
    end

    it "defines the setter so that a value not in the set's option is not passed to the hstore" do
      bad_value = "hackery_nonsense"
      @it.send(@method_names.setter, bad_value)
      @it.send(@method_names.getter).must_be_nil
    end

    it 'persists data sent to setters' do
      random_value = @button_definition.options.sample
      @it.send(@method_names.setter, random_value)
      @it.send(@method_names.getter).must_equal random_value
    end

    it 'allows the use of ActiveModel validation methods' do
      @it.class.validates_presence_of(@method_names.getter)
      @it.valid?.must_equal false
    end

    it 'creates a class instance variable that returns the names of all hstore button names' do
      @it.class.instance_variable_get(:@hstore_button_getters).must_include :test_name
    end
  end
end
