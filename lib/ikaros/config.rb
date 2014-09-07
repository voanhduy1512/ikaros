require 'yaml'
module Ikaros
  class Config
    def initialize(path)
      @config = YAML.load(File.read(path))
      @project_path = ::File.dirname ::File.realpath(path)
      @project_name = @project_path.match(/\w+$/).to_s
    end

    def language
      @config['language']
    end

    def versions
      @config['versions']
    end

    def version
      (@config.versions && @config.versions.first) || nil
    end

    def services
      @config['services']
    end

    def application
      @config.reject{|k,v| k == 'services'}
    end

    def project_path
      @project_path
    end

    def project_name
      @project_name
    end

    def bundle_cache?
      @config['cache']
    end

    def bundle_cache_path
      "#{ENV['CACHE_BUNDLE_PATH']}/#{project_name}"
    end
  end
end
