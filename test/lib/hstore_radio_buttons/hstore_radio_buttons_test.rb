require_relative '../../test_helper.rb'
require 'active_record'
require_relative '../../support/models.rb'

describe HstoreRadioButtons do
  it 'allows a class to respond to hstore_radio_buttons' do
    Person.respond_to?(:hstore_radio_buttons).must_equal true
  end
end
