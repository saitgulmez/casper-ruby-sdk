module CLValueBytesParsers

  module CLStringBytesParser
    def from_bytes(raw_bytes)
      first_4_bytes = raw_bytes[0..7]
      string_length = [first_4_bytes].pack("H*").unpack("l").first
      rest = raw_bytes[8..raw_bytes.length]
      len2 = (rest.length) / 2
      if string_length == len2
        hex_to_string_value = [raw_bytes[8..raw_bytes.length]].pack("H*")
      else
        raise "Error"
      end
    end

    def to_bytes(value)
      len = value.length
      hex_of_value = value.unpack("H*")
      # hex_of_len = [len].
    end

    def to_json 
    end

    def from_json
    end
  end


  module CLI32BytesParser
    @@check = 0
    def from_bytes(byte_array)
      if @@check < 0
        @@check = 0
        bytes = byte_array.map { |b| b.chr }.join
        bytes.unpack("B*").first.scan(/[01]{8}/)
        bytes.reverse.unpack("l*").first
      else
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
      end
    end

    def to_bytes(value)
      if value < 0
        @@check = value
        [value].pack("l>*").unpack("C*")
      else
        [value].pack("l<*").unpack("C*")
      end
    end
  end 

  module CLI64BytesParser
    @@check = 0
    def from_bytes(byte_array)
      if @@check < 0
        @@check = 0
        bytes = byte_array.map { |b| b.chr }.join
        bytes.unpack("B*").first.scan(/[01]{8}/)
        bytes.reverse.unpack("q*").first
      else
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
      end
    end

    def to_bytes(value)
      if value < 0
        @@check = value
        [value].pack("q>*").unpack("C*")
      else
        [value].pack("q<*").unpack("C*")
      end
    end
  end
  
end

