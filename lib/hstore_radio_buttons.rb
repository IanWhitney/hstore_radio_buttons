require "hstore_radio_buttons/version"
require "hstore_radio_buttons/configuration"
require 'active_support/concern'
require 'active_support/dependencies/autoload'

module HstoreRadioButtons
  extend ActiveSupport::Concern
  extend ActiveSupport::Autoload

  autoload :HstoreRadioData

  module ClassMethods
    def hstore_radio_buttons
    end
  end

  def hstore_data_proxy
    hstore_radio_data || build_hstore_radio_data
  end
  private :hstore_data_proxy

  included do
    has_one :hstore_radio_data
    HstoreRadioButtons::Configuration.from_yaml(self)
  end
end
