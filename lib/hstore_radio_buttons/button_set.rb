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
    end
  end
end
