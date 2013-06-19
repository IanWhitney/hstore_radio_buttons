module HstoreRadioButtons
  class Configuration
    def self.from_yaml(model, yaml_file_location = './config/hstore_radio_button_sets.yml')
      self.new._from_yaml(model, yaml_file_location)
    end

    def _from_yaml(model, yaml_file_location)
      self.yaml_file_location = yaml_file_location
      self.model = model

      if yaml_exists?
        button_definitions_from_yaml.each do |button_definition|
          model.send(:define_method, button_definition.to_sym) {
            hstore_data_proxy[button_definition]
          }
          model.send(:define_method, "#{button_definition}=".to_sym) {|value|
            hstore_data_proxy[button_definition] = value
          }
        end
      end
    end

  private
    attr_accessor :model, :yaml_file_location
    def config_file
      File.open(yaml_file_location)
    end

    def yaml_exists?
      File.exists?(yaml_file_location)
    end

    def button_definitions_from_yaml
      YAML.load(config_file)[model.to_s.downcase].keys
    end
  end
end
