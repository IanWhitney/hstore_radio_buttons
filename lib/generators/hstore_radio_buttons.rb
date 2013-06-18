require 'rails/generators/named_base'

module HstoreRadioButtons
  module Generators
    module Base
      def source_root
        @_hstore_radio_buttons_source_root ||= File.expand_path(File.join('../hstore_radio_buttons', generator_name, 'templates'), __FILE__)
      end
    end
  end
end
