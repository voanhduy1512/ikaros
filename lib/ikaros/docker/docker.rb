module Ikaros
  class Docker
    class << self
      def run(image, options)
        command = 'docker run '

        options[:links] && options[:links].each do |key, value|
          command = "#{command} --link #{value}:#{key}"
        end

        if options[:enviroments]
          options[:enviroments].each do |key, value|
            command = "#{command} -e #{key}=#{value}"
          end
        end

        if options[:volumes]
          options[:volumes].each do |key, value|
            command = "#{command} -v #{value}:#{key}"
          end
        end

        if options[:daemon]
          command = "#{command} -d"
        end

        command = "#{command} #{image}"

        if options[:command]
          command = "#{command} #{options[:command]}"
        end

        exec command, options
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
