require_relative './docker'

module Ikaros
  class Container
    attr_accessor :basename, :image, :id

    def initialize(basename, options = {})
      self.basename = basename
      self.image = basename
      @service = options.delete(:service) || Docker
      @options = options
    end

    def image= value
      @image = case value
        when 'ruby'
          'voanhduy1512/ruby'
        when 'postgres'
          'sss_postgresql'
        when 'elasticsearch'
          'dockerfile/elasticsearch'
        when 'sphinxsearch'
          'voanhduy1512/sphinxsearch'
        else
          value
      end
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
