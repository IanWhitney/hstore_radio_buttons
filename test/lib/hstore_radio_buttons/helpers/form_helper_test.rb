require_relative '../../../test_helper.rb'
require 'action_view/test_case'

class FormHelperTest < ActionView::TestCase
  include ActionView::TestCase::Behavior

  test "adds my FormHelper to Rails' FormHelper" do
    assert ActionView::Helpers::FormHelper.include?(HstoreRadioButtons::FormHelper)
    assert ActionView::Base.include?(HstoreRadioButtons::FormHelper)
  end

  test "view can respond to hstore_radio_button" do
    assert view.respond_to?(:hstore_radio_button)
  end

  test "returns a radio input, label and separator of <br />" do
    it = view.hstore_radio_button(:person, :gender, 'male', separator: "<br />")
    expected = ""
    expected += view.radio_button(:person, :gender, 'male', {})
    expected += view.label(:person, 'male', {})
    expected += "<br />"
    assert_equal expected, it
  end
end
