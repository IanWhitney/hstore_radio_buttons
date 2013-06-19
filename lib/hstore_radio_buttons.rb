require "hstore_radio_buttons/version"
require "hstore_radio_buttons/configuration"
require 'active_support/concern'

module HstoreRadioButtons
  extend ActiveSupport::Concern

  module ClassMethods
    def hstore_radio_buttons
    end
  end

  included do
    has_one :hstore_radio_data
    configuration = HstoreRadioButtons::Configuration.new.build_for_model(self)
    configuration.button_sets.each do |button_set|
      define_method(button_set.to_sym) {}
      define_method("#{button_set}=".to_sym) {}
    end
  end
end
