require_relative '../../test_helper.rb'

describe HstoreRadioButtons::Configuration do

  describe "#from_yaml" do
    before :each do
      @test_yaml_file_location = './test/support/config/hstore_radio_button_sets.yml'
    end

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
        @button_sets = config[@it.class.to_s.downcase]
        @button_option_double = HstoreRadioButtons::ButtonOptions.new('test',[])
        HstoreRadioButtons::ButtonOptions.stubs(:new).returns(@button_option_double)
      end

      it 'creates a button_set for each button set defined in the config file' do
        @button_sets.each do |button_set|
          HstoreRadioButtons::ButtonSet.expects(:new).with(@button_option_double,@it.class).returns(nil)
        end
        HstoreRadioButtons::Configuration.from_yaml(Person, @test_yaml_file_location)
      end
    end
  end

  describe "#from_hash" do
    describe "accepts a model and a button-defining hash to create a button" do
      it "creates a button_set for each button defined by a hstore_radio_button macro" do
        class Report < ActiveRecord::Base; end
        @button_option_double = HstoreRadioButtons::ButtonOptions.new('test',[])
        HstoreRadioButtons::ButtonOptions.stubs(:new).returns(@button_option_double)

        HstoreRadioButtons::ButtonSet.expects(:new).with(@button_option_double,Report).twice.returns(nil)

        class Report < ActiveRecord::Base
          include HstoreRadioButtons

          hstore_radio_button Hash['viewed' => ['true', 'false']]
          hstore_radio_button Hash['written by' => %w(monkeys interns milton)]
        end
      end
    end
  end
end
