require 'activerecord-postgres-hstore'
module HstoreRadioButtons
  class HstoreRadioData < ActiveRecord::Base
    belongs_to :model, :polymorphic => true
    serialize :parameters, ActiveRecord::Coders::Hstore
  end
end
