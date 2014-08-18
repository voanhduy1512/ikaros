require_relative './docker'

module Ikaros
  class Container
    attr_accessor :image, :id

    def initialize(image, options = {})
      self.image = image
      @service = options.delete(:service) || Docker
      @options = options
    end

    def name
      @service.get_name id
    end

    def start
      @id = @service.run image, @options
    end

    def stop
      @service.stop id
      @service.rm id
    end
  end
end