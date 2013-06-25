module HstoreRadioButtons
  class ButtonOptions
    attr_accessor :name, :options
    def initialize(name, options)
      self.name = name.gsub(/ /,"_").downcase
      self.options = *options
    end
  end
end
