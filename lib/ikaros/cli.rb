require 'thor'

module Ikaros
  class CLI < Thor
    desc 'start', 'start test in docker'
    method_options :debug => :boolean, :aliases => "-d"
    def start
      if options.debug?
        Logger.log_level = ::Logger::DEBUG
      end
      check_requirement

      app_config = Config.new '.ikaros.yml'
      Build.new(app_config, Builder::Docker).run
    end

    private
    def check_requirement
      raise Error::ConfigMissing.new unless have_config_file?
      # raise Error::CacheBundleMissing.new unless have_bundle_cache?
    end

    def have_config_file?
      ::File.exist?('.ikaros.yml')
    end

    def have_bundle_cache?
      ENV['CACHE_BUNDLE_PATH']
    end
  end
end
