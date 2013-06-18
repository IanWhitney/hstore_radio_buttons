require_relative '../../test_helper.rb'
require 'active_record'
require_relative '../../support/models.rb'

describe HstoreRadioButtons do
  it 'responds to hstore_radio_buttons' do
    true.must_equal false
    Person.respond_to?(:hstore_radio_buttons).must_equal true
  end
end
