require_relative '../../test_helper.rb'

describe HstoreRadioButtons do
  it 'adds a HstoreRadioData active record class' do
    HstoreRadioButtons::HstoreRadioData.new.must_equal []
  end

  it 'allows a class to respond to hstore_radio_buttons' do
    Person.must_respond_to :hstore_radio_buttons
  end

  it 'builds a has_one association with the hstore_radio_data table' do
    Person.new.must_respond_to :hstore_radio_data
    Person.new.must_respond_to :build_hstore_radio_data
    #Person.new.build_hstore_radio_data.must_equal {}
  end
end
