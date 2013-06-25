require_relative '../../../test_helper.rb'
require 'action_view/test_case'

class FormBuilderTest < ActionView::TestCase
  test "adds my FormHelper to Rails' FormHelper" do
    assert ActionView::Helpers::FormHelper.include?(HstoreRadioButtons::FormHelper)
    assert ActionView::Helpers::FormBuilder.include?(HstoreRadioButtons::FormBuilder)
    assert ActionView::Base.include?(HstoreRadioButtons::FormHelper)
  end

  test "FormHelper instances can respond to hstore_radio_button" do
    template = Object.new
    it = ActionView::Helpers::FormBuilder.new(:person, Person.new, template, {:url => 'test'}, proc {})
    assert it.respond_to?(:hstore_radio_button)
  end
end
