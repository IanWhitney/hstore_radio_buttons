module HstoreRadioButtons
  class ButtonOptions
    attr_accessor :name, :options
    def initialize(name, options)
      self.name = name.to_s
      self.options = *options
    end
  end
end
