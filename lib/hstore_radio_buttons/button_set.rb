module HstoreRadioButtons
  class ButtonSet
    def initialize(button_definition, model)
      setter_method = "#{button_definition.name}=".to_sym
      getter_method = button_definition.name.to_sym
      options_method = "#{button_definition.name}_options".to_sym

      model.send(:define_method, getter_method) {
        hstore_data_proxy[button_definition.name]
      }

      model.send(:define_method, setter_method) {|value|
        if self.send(options_method).include?(value)
          hstore_data_proxy[button_definition.name] = value
        else
          hstore_data_proxy[button_definition.name] = nil
        end
      }

      model.send(:define_method, options_method) {
        button_definition.options
      }

      if !model.instance_variable_defined?(:@hstore_button_names)
        model.instance_variable_set(:@hstore_button_names, Set.new)
      end
      all_buttons_on_model = model.send(:instance_variable_get, :@hstore_button_names)

      model.send(:instance_variable_set, :@hstore_button_names, all_buttons_on_model << button_definition.name.to_sym)
    end
  end
end
