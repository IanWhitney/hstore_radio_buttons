module HstoreRadioButtons
  class ButtonSet
    def initialize(button_definition, model)
      namer = MethodNamer.new(button_definition.name)

      create_instance_methods(button_definition, model, namer)
      create_getters_on_class(model, namer)
    end

    private

    def create_instance_methods(button_definition, model, namer)
      create_getter(button_definition, model, namer)
      create_setter(button_definition, model, namer)
      create_options(button_definition, model, namer)
    end

    def create_getter(button_definition, model, namer)
      model.send(:define_method, namer.getter) {
        hstore_data_proxy[button_definition.name]
      }
    end

    def create_setter(button_definition, model, namer)
      model.send(:define_method, namer.setter) {|value|
        if self.send(namer.options).include?(value)
          hstore_data_proxy[button_definition.name] = value
        else
          hstore_data_proxy[button_definition.name] = nil
        end
      }
    end

    def create_options(button_definition, model, namer)
      model.send(:define_method, namer.options) {
        button_definition.options
      }
    end

    def create_getters_on_class(model, namer)
      if !model.instance_variable_defined?(:@hstore_button_getters)
        model.instance_variable_set(:@hstore_button_getters, Set.new)
      end
      all_buttons_on_model = model.send(:instance_variable_get, :@hstore_button_getters)

      model.send(:instance_variable_set, :@hstore_button_getters, all_buttons_on_model << namer.getter)
    end
  end

  class MethodNamer
    def initialize(button_name)
      self.button_name = button_name
    end

    def setter
      "#{button_name}=".to_sym
    end

    def getter
      button_name.to_sym
    end

    def options
      "#{button_name}_options".to_sym
    end

    private
    attr_accessor :button_name
  end
end
