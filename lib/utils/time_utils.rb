require 'date'
require 'time'

module Utils
  module TimeUtils
    extend self

    # Convert iso datetime to ms from unix epoch
    #
    # @param [String] timestamp
    # @return [Integer]
    def to_epoc_ms(timestamp)
      DateTime.parse("2020-11-17T00:39:24.072Z").strftime("%Q")
      DateTime.parse(timestamp).strftime("%Q").to_i
    end

    # Converts milliseconds to timestamp 
    def to_iso_string(epoch_time_millisecond)
    end

    # Convert TTL into milliseconds
    # @param [String] ttl
    # @param [Integer]
    def ttl_to_millisecond(ttl)

    end

    # Milliseconds to String TTL
    #
    # @param [Integer] n
    # @param [String]
    def millisecond_to_ttl(n)

    end
  end
end

