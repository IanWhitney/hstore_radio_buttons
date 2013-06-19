lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'hstore_radio_buttons'
HstoreRadioButtons::Configuration::YAML_FILE_LOCATION = './test/support/config/hstore_radio_button_sets.yml'

require 'minitest/autorun'

require 'active_record'
require_relative 'support/models.rb'
require_relative 'support/schema.rb'

CreateSchema.suppress_messages{ CreateSchema.migrate(:up) }

MiniTest::Unit.after_tests do
  FileUtils.rm_rf(File.expand_path('../test.db', __FILE__))
end
