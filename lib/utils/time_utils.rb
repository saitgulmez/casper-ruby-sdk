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

    # Convert ttl into milliseconds
    # @param [String] ttl
    # @return [Integer]
    def ttl_to_milliseconds(ttl)
      arr = ttl.split(' ')
      total_time = 0
      n = 1
      for item in arr do
        if item.include?("h")
          n = 60 * 60 * 1000
        elsif item.include?("m") && !item.include?("ms")
          n = 60 * 1000
        elsif item.include?("s") && !item.include?("ms")
          n = 1000
        elsif item.include?("ms")
          n = 1
        elsif item.include?("d")
          n = 24 * 60 * 60 * 1000
        elsif item.include?("day")
          n = 24 * 60 * 60 * 1000
        end
          value = item.gsub(/[^0-9,.]/, "").to_i
          value *= n
          total_time += value 
          n = 1
      end
      total_time
    end

    # Milliseconds to String TTL
    #
    # @param [Integer] milliseconds
    # @return [String]
    def milliseconds_to_ttl(milliseconds)
      return '' unless milliseconds
      days, milliseconds   = milliseconds.divmod(1000 * 60 * 60 * 24)
      hours, milliseconds   = milliseconds.divmod(1000 * 60 * 60)
      minutes, milliseconds = milliseconds.divmod(1000 * 60)
      seconds, milliseconds = milliseconds.divmod(1000)
     str = "#{days}d #{hours}h #{minutes}m #{seconds}s #{milliseconds}ms"
     arr = str.split(" ")
     new_str = ""
     for item in arr  do  
      if item[0] != '0'
        new_str += item + " "
      end
     end
     new_str.rstrip
    end

    def get_duration_hrs_mins_secs_ms(milliseconds)
      return '' unless milliseconds
      hours, milliseconds   = milliseconds.divmod(1000 * 60 * 60)
      minutes, milliseconds = milliseconds.divmod(1000 * 60)
      seconds, milliseconds = milliseconds.divmod(1000)
      "#{hours}h #{minutes}m #{seconds}s #{milliseconds}ms"
    rescue 
      ""
    end

  end
end

