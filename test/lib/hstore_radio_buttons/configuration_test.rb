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
        config = YAML.load(File.open(@test_yaml_file_location))
        @button_sets = config["person"].keys
      end

      it 'creates a button_set for each button set defined in the config file' do
        @button_sets.each do |button_set|
          HstoreRadioButtons::ButtonSet.expects(:new).with(button_set,@it.class).returns(nil)
        end
        HstoreRadioButtons::Configuration.from_yaml(Person, @test_yaml_file_location)
      end
    end
  end
end
