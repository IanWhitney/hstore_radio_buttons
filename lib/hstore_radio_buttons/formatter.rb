module HstoreRadioButtons
  class Formatter
    def initialize(raw_button_name)
      self.raw_button_name = raw_button_name
    end

    def to_method
      raw_button_name.to_s.gsub(/ /,"_").downcase
    end

    def to_title
      raw_button_name.to_s.gsub(/_/," ").titleize
    end

    private

    attr_accessor :raw_button_name
  end
end
