module HstoreRadioButtons
  class Configuration
    def self.from_yaml(model, yaml_file_location = './config/hstore_radio_button_sets.yml')
      if yaml_exists?(yaml_file_location)
        button_sets = YAML.load(config_file(yaml_file_location))[model.to_s.downcase].keys
        button_sets.each do |button_set|
          model.send(:define_method, button_set.to_sym) {
            hstore_data_proxy[button_set]
          }
          model.send(:define_method, "#{button_set}=".to_sym) {|value|
            hstore_data_proxy[button_set] = value
          }
        end
      end
    end

    private

    def self.config_file(yaml_file_location)
      File.open(yaml_file_location)
    end

    def self.yaml_exists?(yaml_file_location)
      File.exists?(yaml_file_location)
    end
  end
end
