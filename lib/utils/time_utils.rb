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
      DateTime.parse( ).strftime("%Q")
      DateTime.parse(timestamp).strftime("%Q").to_i
    end

    # Converts milliseconds to timestamp 
    def to_iso_string(milliseconds)
      milliseconds -= 3 * 60 * 60 * 1000
      Time.at(milliseconds/1000.0).strftime('%Y-%m-%dT%H:%M:%S.%3NZ')
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

