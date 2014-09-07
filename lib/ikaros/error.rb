module Ikaros
  module Error
    class Error < StandardError; end

    class CommandError < Error; end

    class ConfigMissing < Error; end

    class CacheBundleMissing < Error; end
  end
end
