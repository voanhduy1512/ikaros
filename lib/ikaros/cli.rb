require 'thor'
require_relative './config'
require_relative './runner'

module Ikaros
  class CLI < Thor
    desc "start", "start test in docker"
    def start
      if File.exist?('.ikaros.yml')
        config_file = Config.new '.ikaros.yml'
        Runner.new(config_file).run
      else
      end
    end
  end
end
