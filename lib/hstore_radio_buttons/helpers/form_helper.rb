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
  include ActionView::Helpers::TagHelper

  def hstore_radio_button(method, options = {})
    options[:separator] = (options[:separator] ? options[:separator] : "<br />")
    radio_options = object.public_send("#{method}_options".to_sym)
    button_set = "#{method.to_s.titleize}#{options[:separator]}"
    radio_options.each do |radio_option|
      button_set += @template.hstore_radio_button(@object_name, method, radio_option, objectify_options(options))
    end
    content_tag(:div, button_set.html_safe).html_safe
  end

  def hstore_radio_buttons(options = {})
    all_buttons = ""
    object.class.instance_variable_get(:@hstore_button_getters).each do |method|
      all_buttons += hstore_radio_button(method, options)
    end
    all_buttons.html_safe
  end
end

ActionView::Helpers::FormHelper.send(:include, HstoreRadioButtons::FormHelper)
ActionView::Base.send(:include, HstoreRadioButtons::FormHelper)
ActionView::Helpers::FormBuilder.send(:include, HstoreRadioButtons::FormBuilder)
