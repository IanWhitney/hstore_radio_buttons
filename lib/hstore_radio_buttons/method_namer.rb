module HstoreRadioButtons
  class MethodNamer
    def initialize(button_name)
      self.button_name = HstoreRadioButtons::Formatter.new(button_name).to_method
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
