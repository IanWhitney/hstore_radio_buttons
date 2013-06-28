module HstoreRadioButtons
  class ButtonDefinition
    attr_accessor :name
    attr_reader   :options

    def options=(x)
      @options = *x
    end
  end
end
