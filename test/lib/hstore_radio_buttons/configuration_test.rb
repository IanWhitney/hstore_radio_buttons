require_relative '../../test_helper.rb'

describe HstoreRadioButtons::Configuration do
  before :each do
    @test_yaml_file_location = './test/support/config/hstore_radio_button_sets.yml'
  end

  describe "#from_yaml" do
    it "checks if a provided yaml file exists" do
      File.expects(:exists?).with(@test_yaml_file_location).returns(true)
      HstoreRadioButtons::Configuration.from_yaml(Person, @test_yaml_file_location)
    end

    it "checks if the default yaml file exists if none provided" do
      yaml_file_location = './config/hstore_radio_button_sets.yml'
      File.expects(:exists?).with(yaml_file_location).returns(false)
      HstoreRadioButtons::Configuration.from_yaml(Person, yaml_file_location)
    end

    describe "has a yaml file to use" do
      before :each do
        @it = Person.new
        HstoreRadioButtons::Configuration.from_yaml(Person, @test_yaml_file_location)
        config = YAML.load(File.open(@test_yaml_file_location))
        @button_sets = config["person"].keys
      end

      it 'adds getters and setters for the button sets defined in the config file' do
        @button_sets.each do |button_set|
          @it.must_respond_to button_set.to_sym
          @it.must_respond_to "#{button_set}=".to_sym
        end
      end

      it "persists data sent to setters" do
        @button_sets.each do |button_set|
          random_value = rand(1000)
          @it.send("#{button_set}=".to_sym, random_value)
          @it.send(button_set.to_sym).must_equal random_value
        end
      end
    end
  end
end
