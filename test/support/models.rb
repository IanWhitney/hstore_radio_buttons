class Person < ActiveRecord::Base
  include HstoreRadioButtons

  hstore_radio_buttons './test/support/config/hstore_radio_button_sets.yml'
end

