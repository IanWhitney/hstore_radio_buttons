module HstoreRadioButtons
  class ButtonDefinition
    attr_reader   :options, :name

    def name=(x)
      @name = x.to_s
    end

    def options=(x)
      @options = *x
    end
  end
end
