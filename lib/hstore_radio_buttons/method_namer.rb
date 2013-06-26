module HstoreRadioButtons
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

    def button_name=(x)
      @button_name = x.to_s.gsub(/ /,"_").downcase
    end
  end
end
