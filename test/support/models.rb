class Person < ActiveRecord::Base
  include HstoreRadioButtons

  hstore_radio_buttons
end
