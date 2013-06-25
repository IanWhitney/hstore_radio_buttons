require_relative '../../../test_helper.rb'
require 'action_view/test_case'

class FormBuilderTest < ActionView::TestCase
  include ActiveSupport::Testing::SetupAndTeardown
  include ActionView::TestCase::Behavior

  test "adds my FormHelper to Rails' FormHelper" do
    assert ActionView::Helpers::FormHelper.include?(HstoreRadioButtons::FormHelper)
    assert ActionView::Helpers::FormBuilder.include?(HstoreRadioButtons::FormBuilder)
    assert ActionView::Base.include?(HstoreRadioButtons::FormHelper)
  end

  test "FormBuilder instances can respond to hstore_radio_button" do
    it = ActionView::Helpers::FormBuilder.new(:person, Person.new, view, {}, proc {})
    assert it.respond_to?(:hstore_radio_button)
  end

  test "FormBuilder#hstore_radio_button returns a set of buttons that are prefaced with the button set's name" do
    person_instance = Person.new
    view.stubs(:hstore_radio_button).with(any_parameters).returns("")
    it = ActionView::Helpers::FormBuilder.new(:person, person_instance, view, {}, proc {})
    assert_match /^Gender/, it.hstore_radio_button(:gender)
  end

  test "FormBuilder#hstore_radio_button gets a button from FormHelper for each value in the _options method" do
    person_instance = Person.new
    expected = "Gender<br />"
    person_instance.gender_options.each do |option|
      view.stubs(:hstore_radio_button).with(:person, :gender, option, {:object => person_instance}).returns(option)
      expected += "#{option}"
    end

    it = ActionView::Helpers::FormBuilder.new(:person, person_instance, view, {}, proc {})

    assert_equal expected, it.hstore_radio_button(:gender)
  end
end
