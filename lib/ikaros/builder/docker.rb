require 'ikaros/docker/command'
require 'ikaros/docker/docker'
require 'ikaros/docker/container'

module Ikaros
  module Builder
    class Docker < Base
      def run
        start_services
        test
        stop_services
      end

      def start_services
        @containers = []
        @services.each do |service|
          container = Container.new(service, daemon: true)
          container.start
          @containers << container
        end
      end

      def test
        app = Container.new(@application.language, options_for_main_container)
        app.start
      end

      def stop_services
        @containers.each {|c| c.stop}
      end

      def options_for_main_container
        enviroments = {}
        links = {}
        @containers.each do |container|
          case container.basename
          when 'redis'
            enviroments['REDISTOGO_URL'] = 'redis://redis'
            enviroments['REDIS_URL'] = 'redis://redis'
          when 'elasticsearch'
            enviroments['ELASTICSEARCH_URL'] = 'http://elasticsearch:9200'
          end

          links[container.basename] = container.name
        end

        volumes = {
          '/code' => @application.project_path,
          '/bundle' => @application.bundle_cache_path
        }

        {
          links: links,
          enviroments: enviroments,
          command: 'env',
          volumes: volumes,
          output: true
        }
      end
    end
  end
end
