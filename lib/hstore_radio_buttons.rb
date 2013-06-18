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
  end
end
