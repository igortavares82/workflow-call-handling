require 'logging'

module MariaCallCenter
  module Log
    def logger
      Logging.logger[self]
    end

    def logger_context
      Logging.mdc
    end

    def self.included(base)
      base.extend self
    end
  end
end
