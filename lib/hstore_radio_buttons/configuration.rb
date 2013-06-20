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
        button_options_from_yaml.each {|button_options| HstoreRadioButtons::ButtonSet.new(button_options,model)}
      end
    end

    def _from_hash(model, raw_button_options)
      self.model = model
      button_options = button_options_from_raw(raw_button_options)
      HstoreRadioButtons::ButtonSet.new(button_options,model)
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
        button_options << button_options_from_raw(raw_button_options)
      end
      button_options
    end

    def button_options_from_raw(raw_button_options)
      if raw_button_options.respond_to?(:keys)
        ButtonOptions.new(raw_button_options.keys.first, raw_button_options.values.first)
      else
        ButtonOptions.new(raw_button_options[0], raw_button_options[1])
      end
    end
  end
end
