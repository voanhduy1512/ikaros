require_relative './container'

module Ikaros
  class Runner
    def initialize(config)
      @config = config
      @containers = []
    end

    def run
      start_services
      run_test
      stop_services
    end

    private
    def start_services
      @config.services.each do |service|
        container = Container.new(service)
        container.start
        @containers << container
      end
    end

    def run_test
      main_image = case @config.app_type
        when 'ruby'
          'voanhduy1512/ruby'
      end
      app = Container.new(main_image, links: @containers)
      app.start
    end

    def stop_services
      @containers.each do |container|
        container.stop
      end
    end
  end
end