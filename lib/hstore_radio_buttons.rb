require 'action_view'
require 'active_support/concern'
require 'active_support/dependencies/autoload'

require 'hstore_radio_buttons/version'
require 'hstore_radio_buttons/configuration'
require 'hstore_radio_buttons/button_options'
require 'hstore_radio_buttons/button_set'
require 'hstore_radio_buttons/method_namer'
require 'hstore_radio_buttons/helpers/form_helper'

module HstoreRadioButtons
  extend ActiveSupport::Concern
  extend ActiveSupport::Autoload

  autoload :HstoreRadioData

  module ClassMethods
    def hstore_radio_buttons(yaml_file_location = './config/hstore_radio_button_sets.yml')
      HstoreRadioButtons::Configuration.from_yaml(self,yaml_file_location)
    end

    def hstore_radio_button(button_hash)
      HstoreRadioButtons::Configuration.from_hash(self, button_hash)
    end
  end

  def hstore_data_proxy
    if self.hstore_radio_data.nil?
      self.build_hstore_radio_data.hstore_data
    else
      self.hstore_radio_data.hstore_data
    end
  end
  private :hstore_data_proxy

  included do
    has_one :hstore_radio_data, :class_name => 'HstoreRadioButtons::HstoreRadioData', :as => :model
  end
end
