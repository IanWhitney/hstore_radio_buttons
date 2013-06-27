module HstoreRadioButtons
  class MethodNamer
    def initialize(button_name)
      self.button_name = button_name.to_s.gsub(/ /,"_").downcase
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
