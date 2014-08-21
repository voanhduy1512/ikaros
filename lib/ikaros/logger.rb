require 'logger'

module Ikaros
  class Logger < ::Logger

    class << self
      attr_accessor :log_level

      def log_level
        @log_level ||= self::INFO
      end
    end

    def initialize(*args)
      super
      self.level = self.class.log_level
      @formatter = SimpleFormatter.new
    end

  end

  class SimpleFormatter < ::Logger::Formatter
    def call(severity, timestamp, progname, msg)
      "#{String === msg ? msg : msg.inspect}\n"
    end
  end
end
