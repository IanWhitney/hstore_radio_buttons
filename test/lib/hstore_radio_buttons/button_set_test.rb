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

    it 'persists data sent to setters' do
      @button_definitions.each do |button_definition|
        random_value = rand(1000)
        @it.send("#{button_definition.name}=".to_sym, random_value)
        @it.send(button_definition.name.to_sym).must_equal random_value
      end
    end
  end
end
