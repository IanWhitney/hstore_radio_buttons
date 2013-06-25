require 'action_view'

module HstoreRadioButtons::FormHelper
  def hstore_radio_button(object_name, method, tag_value, options = {})
    separator = options.delete(:separator)
    label = label(object_name, tag_value, options)
    input = radio_button(object_name, method, tag_value, options)
    "#{input}#{label}#{separator}"
  end
end

module HstoreRadioButtons::FormBuilder
  def hstore_radio_button(method, options = {})
    separator = options[:separator] || "<br />"
    radio_options = object.public_send("#{method}_options".to_sym)
    button_set = "#{method.to_s.titleize}#{separator}"
    radio_options.each do |radio_option|
      button_set += @template.hstore_radio_button(@object_name, method, radio_option, objectify_options(options))
    end
    button_set.html_safe
  end

  #def hstore_radio_buttons(options = {})
    #@template.hstore_radio_buttons(@object_name, method, objectify_options(options))
  #end
end

ActionView::Helpers::FormHelper.send(:include, HstoreRadioButtons::FormHelper)
ActionView::Base.send(:include, HstoreRadioButtons::FormHelper)
ActionView::Helpers::FormBuilder.send(:include, HstoreRadioButtons::FormBuilder)
