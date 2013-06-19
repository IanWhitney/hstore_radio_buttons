module HstoreRadioButtons
  class ButtonSet
    def initialize(button_definition, model)
      model.send(:define_method, button_definition.to_sym) {
        hstore_data_proxy[button_definition]
      }
      model.send(:define_method, "#{button_definition}=".to_sym) {|value|
        hstore_data_proxy[button_definition] = value
      }
    end
  end
end
