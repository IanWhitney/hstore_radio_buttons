require_relative '../../../test_helper.rb'
require 'action_view/test_case'

class FormHelperTest < ActionView::TestCase
  #include ActiveSupport::Testing::SetupAndTeardown
  #include ActionView::TestCase::Behavior

  #setup do
    #@person_instance = Person.new
  #end

  test "adds my FormHelper to Rails' FormHelper" do
    assert ActionView::Helpers::FormHelper.include?(HstoreRadioButtons::FormHelper)
    assert ActionView::Base.include?(HstoreRadioButtons::FormHelper)
  end
end
