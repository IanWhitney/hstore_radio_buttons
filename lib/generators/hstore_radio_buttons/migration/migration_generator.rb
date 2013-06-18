require 'generators/hstore_radio_buttons'
require 'rails/generators/active_record'

module HstoreRadioButtons
  module Generators
    class MigrationGenerator < ActiveRecord::Generators::Base
      extend Base

      argument :name, :type => :string, :default => 'create_hstore_radio_data'

      def generate_files
        migration_template 'migration.rb', "db/migrate/#{name}"
      end
    end
  end
end
