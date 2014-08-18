require 'open3'

module Ikaros
  class Docker
    class << self
      def run(image, options)
        command = "docker run #{image}"
        options[:links] && options[:links].each do |container|
          command = "#{command} --link #{container.name}:#{container.image}"
        end
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
        stdin, stdout, stderr, wait_thr = Open3.popen3(command)
      end
    end
  end
end