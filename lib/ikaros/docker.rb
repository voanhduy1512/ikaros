require 'open3'

module Ikaros
  class Docker
    class << self
      def run(image, options)
        command = "docker run "
        options[:links] && options[:links].each do |container|
          command = "#{command} --link #{container.name}:#{container.image}"
        end
        if options[:daemon]
          command = "#{command} -d"
        end
        command = "#{command} #{image}"
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

      def exec(command)
        result  = ''
        exit_code = 0
        Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
          while line = stdout.gets
            result = "#{result}#{line}"
            puts line
          end

          exit_code = wait_thr.value.exitstatus

        end
        puts exit_code
        result, exit_code
      end
    end
  end
end