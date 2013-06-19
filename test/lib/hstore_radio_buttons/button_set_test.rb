require_relative '../../test_helper.rb'

describe HstoreRadioButtons::ButtonSet do
  describe '#initialize' do
    before :each do
      @test_yaml_file_location = './test/support/config/hstore_radio_button_sets.yml'
      @it = Person.new
      config = YAML.load(File.open(@test_yaml_file_location))
      @button_definitions = config['person'].keys
      @button_definitions.each do |button_definition|
        HstoreRadioButtons::ButtonSet.new(button_definition,@it.class)
      end
    end

    it 'adds getters and setters for the button sets defined in the config file' do
      @button_definitions.each do |button_definition|
        @it.must_respond_to button_definition.to_sym
        @it.must_respond_to "#{button_definition}=".to_sym
      end
    end

    it 'persists data sent to setters' do
      @button_definitions.each do |button_definition|
        random_value = rand(1000)
        @it.send("#{button_definition}=".to_sym, random_value)
        @it.send(button_definition.to_sym).must_equal random_value
      end
    end
  end
end
