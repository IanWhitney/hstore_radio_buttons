require "hstore_radio_buttons/version"

module HstoreRadioButtons
  module ClassMethods
    def hstore_radio_buttons

    end
  end

  def self.included(receiver)
    receiver.extend      ClassMethods
  end
end
