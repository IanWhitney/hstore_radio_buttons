require_relative '../../test_helper.rb'

describe HstoreRadioButtons do
  it 'allows a class to respond to hstore_radio_buttons' do
    Person.must_respond_to :hstore_radio_buttons
  end

  it 'builds a has_one association with the hstore_radio_data table' do
    Person.new.must_respond_to :hstore_radio_data
  end

  it 'adds getters and setters for the button sets defined in the config file' do
    it = Person.new
    config_file = File.open('./test/support/config/hstore_radio_button_sets.yml')
    config = YAML.load(config_file)
    button_sets = config["person"].keys
    button_sets.each do |button_set|
      it.must_respond_to button_set.to_sym
      it.must_respond_to "#{button_set}=".to_sym
    end
  end
end
