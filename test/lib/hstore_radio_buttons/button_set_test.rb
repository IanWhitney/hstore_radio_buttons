require_relative '../../test_helper.rb'

describe HstoreRadioButtons::ButtonSet do
  describe '#initialize' do
    before :each do
      @test_yaml_file_location = './test/support/config/hstore_radio_button_sets.yml'
      @it = Person.new
      config = YAML.load(File.open(@test_yaml_file_location))
      @raw_button_definitions = config[@it.class.to_s.downcase]
      @button_definitions = []

      @raw_button_definitions.each do |button_definition|
        button_options = HstoreRadioButtons::ButtonOptions.new(button_definition[0],button_definition[1])
        @button_definitions << button_options
        HstoreRadioButtons::ButtonSet.new(button_options,@it.class)
      end
    end

    it 'adds getters and setters for the button sets defined in the config file' do
      @button_definitions.each do |button_definition|
        @it.must_respond_to button_definition.name.to_sym
        @it.must_respond_to "#{button_definition.name}=".to_sym
      end
    end

    it "adds a method that returns the button set's options" do
      @button_definitions.each do |button_definition|
        @it.must_respond_to "#{button_definition.name}_options".to_sym
        @it.send("#{button_definition.name}_options".to_sym).must_equal button_definition.options
      end
    end

    it "defines the setter so that a value not in the set's option is not passed to the hstore" do
      bad_value = "hackery_nonsense"
      @button_definitions.each do |button_definition|
        @it.send("#{button_definition.name}=".to_sym, bad_value)
        @it.send(button_definition.name.to_sym).must_be_nil
      end
    end

    it 'persists data sent to setters' do
      @button_definitions.each do |button_definition|
        random_value = button_definition.options.sample
        @it.send("#{button_definition.name}=".to_sym, random_value)
        @it.send(button_definition.name.to_sym).must_equal random_value
      end
    end

    it 'allows the use of ActiveModel validation methods' do
      @it.class.validates_presence_of(@button_definitions.sample.name)
      @it.valid?.must_equal false
    end

    it 'creates a class instance variable that returns the names of all hstore button names' do
      @it.class.instance_variable_get(:@hstore_button_getters).must_equal @button_definitions.map {|d| d.name.to_sym}.to_set
    end
  end
end
