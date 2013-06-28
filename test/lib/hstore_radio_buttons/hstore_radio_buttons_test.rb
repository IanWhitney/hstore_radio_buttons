require_relative '../../test_helper.rb'

describe HstoreRadioButtons do
  it 'adds a HstoreRadioData active record class' do
    HstoreRadioButtons::HstoreRadioData.new.wont_be_nil
  end

  it 'allows a class to respond to hstore_radio_buttons' do
    Person.must_respond_to :hstore_radio_buttons
  end

  it 'builds a has_one association with the hstore_radio_data table' do
    Person.new.must_respond_to :hstore_radio_data
    Person.new.must_respond_to :build_hstore_radio_data
  end

  it "sets autosave to true for the hstore_radio_data table" do
    Person.reflect_on_association(:hstore_radio_data).options[:autosave].must_equal :true #yes, it is a symbol
  end
end
