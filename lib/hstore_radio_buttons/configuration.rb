module HstoreRadioButtons
  class Configuration
    YAML_FILE_LOCATION = './config/hstore_radio_button_sets.yml'

    Config = Struct.new(:button_sets)

    def initialize()

    end

    def build_for_model(model)
      Config.new(YAML.load(config_file)["person"].keys)
    end

    private

    def config_file
      File.open(YAML_FILE_LOCATION)
    end
  end
end
