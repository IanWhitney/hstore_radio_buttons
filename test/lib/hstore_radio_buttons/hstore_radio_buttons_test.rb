require_relative '../../test_helper.rb'

describe HstoreRadioButtons do
  it 'allows a class to respond to hstore_radio_buttons' do
    Person.respond_to?(:hstore_radio_buttons).must_equal true
  end

  it 'builds a has_one association with the hstore_radio_data table' do
    Person.new.respond_to?(:hstore_radio_data).must_equal true
  end
end
