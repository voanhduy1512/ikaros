require 'yaml'
module Ikaros
  class Config
    def initialize(path)
      @config = YAML.load_file path
    end

    def services
      @config['services']
    end

    def app_type
      @config['language']
    end
  end
end
