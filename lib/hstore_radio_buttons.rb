require "hstore_radio_buttons/version"
require 'active_support/concern'

module HstoreRadioButtons
  extend ActiveSupport::Concern

  module ClassMethods
    def hstore_radio_buttons
    end
  end

  included do
    has_one :hstore_radio_data
    config_file = File.open('./test/support/config/hstore_radio_button_sets.yml')
    config = YAML.load(config_file)
    button_sets = config["person"].keys
    button_sets.each do |button_set|
      define_method(button_set.to_sym) {}
      define_method("#{button_set}=".to_sym) {}
    end
  end
end
