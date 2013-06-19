module HstoreRadioButtons
  class Configuration
    def self.from_yaml(model, yaml_file_location = './config/hstore_radio_button_sets.yml')
      self.new._from_yaml(model, yaml_file_location)
    end

    def _from_yaml(model, yaml_file_location)
      self.yaml_file_location = yaml_file_location
      self.model = model

      if yaml_exists?
        button_options_from_yaml.each {|button_options| HstoreRadioButtons::ButtonSet.new(button_options,model)}
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

    def button_options_from_yaml
      button_options = []
      YAML.load(config_file)[model.to_s.downcase].each do |raw_button_options|
        button_options << ButtonOptions.new(raw_button_options[0], raw_button_options[1])
      end
      button_options
    end
  end
end
