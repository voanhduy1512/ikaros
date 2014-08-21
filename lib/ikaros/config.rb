require 'yaml'
module Ikaros
  class Config
    def initialize(path)
      @path = path
      @config = YAML.load_file @path
      @dir_path = ::File.dirname ::File.realpath(@path)
      @dir_name = @dir_path.match(/\w+$/).to_s
    end

    def services
      @config['services']
    end

    def app_type
      @config['language']
    end

    def project_path
      @dir_path
    end

    def project_name
      @dir_name
    end
  end
end
