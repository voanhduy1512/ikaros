module Ikaros
  class Build
    def initialize(config, builder)
      @config = config
      @builder = builder
    end

    def run
      Ikaros.logger.debug 'Running test'
      @builder.new(@config, @config.services).run
      Ikaros.logger.debug 'Running test successful'
    end
  end
end
