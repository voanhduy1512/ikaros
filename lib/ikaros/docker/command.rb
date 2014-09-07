require 'open3'

module Ikaros
  class Command
    def initialize(command, options={})
      @command = command
      @options = options
    end

    def run
      logger.debug @command
      result = ''
      Open3.popen3(@command) do |stdin, stdout, stderr, wait_thr|
        while line = stdout.gets
          result = "#{result}#{line}"
          logger.debug line unless output?
          logger.info line if output?
        end
        unless wait_thr.value.success?
          raise Error::CommandError.new stderr.gets(nil)
        end
      end
      result.chomp
    end

    private
    def output?
      @options[:output]
    end

    def logger
      @logger ||= Ikaros.logger
    end
  end
end
