module HstoreRadioButtons
  class Configuration
    def self.from_yaml(model, yaml_file_location = './config/hstore_radio_button_sets.yml')
      self.new._from_yaml(model, yaml_file_location)
    end

    def self.from_hash(model, raw_button_options)
      self.new._from_hash(model, raw_button_options)
    end

    def _from_yaml(model, yaml_file_location)
      self.yaml_file_location = yaml_file_location
      self.model = model

      if yaml_exists?
        button_defititions_from_yaml.each {|button_definition| build_button_from_definition(button_definition, model)}
      end
    end

    def _from_hash(model, raw_button_options)
      self.model = model
      button_definition = create_button_definiton(raw_button_options)
      build_button_from_definition(button_definition,model)
    end

  private
    attr_accessor :model, :yaml_file_location
    def config_file
      File.open(yaml_file_location)
    end

    def yaml_exists?
      File.exists?(yaml_file_location)
    end

    def button_defititions_from_yaml
      button_definitions = []
      YAML.load(config_file)[model.to_s.downcase].each do |key, value|
        button_definitions << create_button_definiton(Hash[key,value])
      end
      button_definitions
    end

    def create_button_definiton(raw_button_options)
      b = ButtonDefinition.new
      b.name = raw_button_options.keys.first
      b.options = raw_button_options.values.first
      b
    end

    def build_button_from_definition(button_definition,model)
      HstoreRadioButtons::ButtonSet.new(button_definition,model)
    end
  end
end
