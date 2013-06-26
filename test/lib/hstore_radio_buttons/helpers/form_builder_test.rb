require_relative '../../../test_helper.rb'
require 'action_view/test_case'

class FormBuilderTest < ActionView::TestCase
  include ActiveSupport::Testing::SetupAndTeardown
  include ActionView::TestCase::Behavior

  setup do
    @person_instance = Person.new
  end

  test "adds my FormHelper to Rails' FormHelper" do
    assert ActionView::Helpers::FormBuilder.include?(HstoreRadioButtons::FormBuilder)
  end

  test "FormBuilder instances can respond to hstore_radio_button" do
    it = ActionView::Helpers::FormBuilder.new(:person, @person_instance, view, {}, proc {})
    assert it.respond_to?(:hstore_radio_button)
  end

  test "FormBuilder#hstore_radio_button wraps the whole thing in a div" do
    view.stubs(:hstore_radio_button).with(any_parameters).returns("")
    it = ActionView::Helpers::FormBuilder.new(:person, @person_instance, view, {}, proc {})
    assert_match /^<div>/, it.hstore_radio_button(:gender)
    assert_match /<\/div>$/, it.hstore_radio_button(:gender)
  end

  test "FormBuilder#hstore_radio_button returns a set of buttons that are prefaced with the button set's name" do
    view.stubs(:hstore_radio_button).with(any_parameters).returns("")
    it = ActionView::Helpers::FormBuilder.new(:person, @person_instance, view, {}, proc {})
    assert_match /^<div>Gender/, it.hstore_radio_button(:gender)
  end

  test "#hstore_radio_button accepts a separator, which will be used to separate the button-set header from the buttons" do
    view.stubs(:hstore_radio_button).with(any_parameters).returns("")
    it = ActionView::Helpers::FormBuilder.new(:person, @person_instance, view, {}, proc {})
    assert_match /^<div>Gender-/, it.hstore_radio_button(:gender, separator: "-")
  end

  test "FormBuilder#hstore_radio_button gets a button from FormHelper for each value in the _options method" do
    expected = "<div>Gender<br />"
    @person_instance.gender_options.each do |option|
      view.stubs(:hstore_radio_button).with(:person, :gender, option, {:separator => "<br />", :object => @person_instance}).returns(option)
      expected += "#{option}"
    end
    expected += "</div>"

    it = ActionView::Helpers::FormBuilder.new(:person, @person_instance, view, {}, proc {})

    assert_equal expected, it.hstore_radio_button(:gender)
  end

  test "#hstore_radio_buttons builds a button set for each button defined in the class" do
    it = ActionView::Helpers::FormBuilder.new(:person, @person_instance, view, {}, proc {})

    all_buttons = Person.instance_variable_get(:@hstore_button_getters)
    expected = ""
    all_buttons.each do |b|
      expected += it.hstore_radio_button(b)
    end

    assert_equal expected, it.hstore_radio_buttons
  end
end
