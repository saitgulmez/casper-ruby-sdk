module CLValueBytesParsers

  module CLStringBytesParser
    def from_bytes(raw_bytes)
      first_4_bytes = raw_bytes[0..7]
      string_length = [first_4_bytes].pack("H*").unpack("l").first
      puts string_length
      rest = raw_bytes[8..raw_bytes.length]
      len2 = (rest.length) / 2
      if string_length == len2
        hex_to_string_value = [raw_bytes[8..raw_bytes.length]].pack("H*")
      else
        raise "Error"
      end
    end

    def to_bytes(value)

    end

    def to_json 
    end

    def from_json
    end
  end
  
end

