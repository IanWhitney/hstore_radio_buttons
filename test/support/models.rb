class Person < ActiveRecord::Base
  include HstoreRadioButtons

  hstore_radio_buttons './test/support/config/hstore_radio_button_sets.yml'
end

class Report < ActiveRecord::Base
  include HstoreRadioButtons

  hstore_radio_button Hash[viewed: ['true', 'false']]
  hstore_radio_button Hash['written by' => %w(monkeys interns milton)]
end

