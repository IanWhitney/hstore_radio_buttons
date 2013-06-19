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
    HstoreRadioButtons::Configuration.from_yaml(self, './test/support/config/hstore_radio_button_sets.yml')
  end
end
