module HstoreRadioButtons
  class ButtonSet
    def initialize(button_definition, model)
      model.send(:define_method, button_definition.name.to_sym) {
        hstore_data_proxy[button_definition.name]
      }
      model.send(:define_method, "#{button_definition.name}=".to_sym) {|value|
        hstore_data_proxy[button_definition.name] = value
      }
    end
  end
end
