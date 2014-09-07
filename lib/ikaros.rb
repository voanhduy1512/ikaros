require 'ikaros/version'
require 'ikaros/logger'

module Ikaros
  def self.logger
    @logger ||= Logger.new $stdout
  end
end

require 'ikaros/error'
require 'ikaros/config'
# require 'ikaros/service'
# require 'ikaros/service_runner'
# require 'ikaros/application'
require 'ikaros/builder'
require 'ikaros/build'
require 'ikaros/cli'
