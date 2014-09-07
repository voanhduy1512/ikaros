module Ikaros
  module Builder
    class Base
      def initialize(application, services)
        @application = application
        @services = services
      end

      def run
      end
    end
  end
end
