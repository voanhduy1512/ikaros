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
        container = Container.new(service, daemon: true)
        container.start
        @containers << container
      end
    end

    def run_test
      app = Container.new(@config.app_type, options_for_main_container)
      app.start
    end

    def stop_services
      @containers.each do |container|
        container.stop
      end
    end

    private
    def options_for_main_container
      env = {}
      link = {}
      @containers.each do |container|
        case container.basename
        when 'redis'
          env['REDISTOGO_URL'] = 'redis://redis'
          env['REDIS_URL'] = 'redis://redis'
        when 'elasticsearch'
          env['ELASTICSEARCH_URL'] = 'http://elasticsearch:9200'
        end

        link[container.basename] = container.name
      end

      mount = {
        '/code' => @config.project_path,
        '/scripts' => File.expand_path("../scripts", __FILE__),
        '/bundle' => bundle_path
      }

      {
        link: link,
        env: env,
        mount: mount,
        output: true
      }
    end

    def bundle_path
      ENV['CACHE_BUNDLE_PATH']
    end
  end
end
