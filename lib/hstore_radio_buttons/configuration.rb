module HstoreRadioButtons
  class Configuration
    Config = Struct.new(:button_sets)

    def self.from_yaml(model, yaml_file_location = './config/hstore_radio_button_sets.yml')
      if using_yaml?(yaml_file_location)
        button_sets = YAML.load(config_file(yaml_file_location))[model.to_s.downcase].keys
        Config.new(button_sets).button_sets.each do |button_set|
          model.send(:define_method, button_set.to_sym) {}
          model.send(:define_method, "#{button_set}=".to_sym) {}
        end
      end
    end

    private

    def self.config_file(yaml_file_location)
      File.open(yaml_file_location)
    end

    def self.using_yaml?(yaml_file_location)
      File.exists?(yaml_file_location)
    end
  end
end
