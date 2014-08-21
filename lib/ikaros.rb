require 'pry'
require 'ikaros/version'
require 'ikaros/logger'
require 'ikaros/error'
require 'ikaros/cli'

module Ikaros
  extend self
  def logger
    @logger ||= Logger.new $stdout
  end

  def bundle_path

  end
end
