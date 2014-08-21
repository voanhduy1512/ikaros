require_relative './command'


module Ikaros
  class Docker
    class << self
      def run(image, options)
        command = 'docker run '

        options[:link] && options[:link].each do |key, value|
          command = "#{command} --link #{value}:#{key}"
        end

        if options[:env]
          options[:env].each do |key, value|
            command = "#{command} -e #{key}=#{value}"
          end
        end

        if options[:mount]
          options[:mount].each do |key, value|
            command = "#{command} -v #{value}:#{key}"
          end
        end

        if options[:daemon]
          command = "#{command} -d"
        end

        command = "#{command} #{image}"
        command = "#{command} /scripts/ruby.sh" unless options[:daemon]

        exec command
      end

      def stop(id)
        command = "docker stop #{id}"
        exec command
      end

      def get_name(id)
        command = "docker inspect -f '{{ .Name }}' #{id} | cut -d / -f2"
        exec command
      end

      def rm(id)
        command = "docker rm #{id}"
        exec command
      end

      def exec(command, options={})
        Command.new(command, options).run
      end
    end
  end
end
