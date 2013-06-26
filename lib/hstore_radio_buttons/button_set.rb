module HstoreRadioButtons
  class ButtonSet
    def initialize(button_definition, model)
      namer = MethodNamer.new(button_definition)

      model.send(:define_method, namer.getter) {
        hstore_data_proxy[button_definition.name]
      }

      model.send(:define_method, namer.setter) {|value|
        if self.send(namer.options).include?(value)
          hstore_data_proxy[button_definition.name] = value
        else
          hstore_data_proxy[button_definition.name] = nil
        end
      }

      model.send(:define_method, namer.options) {
        button_definition.options
      }

      if !model.instance_variable_defined?(:@hstore_button_getters)
        model.instance_variable_set(:@hstore_button_getters, Set.new)
      end
      all_buttons_on_model = model.send(:instance_variable_get, :@hstore_button_getters)

      model.send(:instance_variable_set, :@hstore_button_getters, all_buttons_on_model << namer.getter)
    end
  end

  class MethodNamer
    def initialize(button_definition)
      self.button_definition = button_definition
    end

    def setter
      "#{button_definition.name}=".to_sym
    end

    def getter
      button_definition.name.to_sym
    end

    def options
      "#{button_definition.name}_options".to_sym
    end

    private
    attr_accessor :button_definition
  end
end
