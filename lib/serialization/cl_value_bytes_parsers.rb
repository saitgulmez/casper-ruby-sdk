require_relative '../types/constants.rb'

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
      if value < 0  && value >= MIN_I32
        @@check = value
        [value].pack("l>*").unpack("C*")
      elsif value >= 0 && value <= MAX_I32
        [value].pack("l<*").unpack("C*")
      else
        "Parameter value '#{value}' is out of range."
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
      if value < 0 && value >= MIN_I64
        @@check = value
        [value].pack("q>*").unpack("C*")
      elsif value >= 0 && value <= MAX_I64
        [value].pack("q<*").unpack("C*")
      else
        "Parameter value '#{value}' is out of range."
      end
    end
  end

  module CLU8BytesParser
    def from_bytes(byte_array)
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
    end

    def to_bytes(value)
      if value < 0 || value > MAX_U8
        @@check = value
        "Parameter value '#{value}' is out of range."
      else
        [value].pack("C").unpack("C")
      end
    end
  end
  
  module CLU32BytesParser
    def from_bytes(byte_array)
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
    end

    def to_bytes(value)
      if value < 0 || value > MAX_U32
        "Parameter value '#{value}' is out of range."
      else
        [value].pack("L<*").unpack("C*")
      end
    end
  end

  module CLU64BytesParser
    def from_bytes(byte_array)
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
    end

    def to_bytes(value)
      if value < 0 || value > MAX_U64
        "Parameter value '#{value}' is out of range."
      else
        [value].pack("Q<*").unpack("C*")
      end
    end
  end

  module CLU128BytesParser
    def from_bytes(byte_array)
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
    end

    def to_bytes(value)
      if value < 0 || value > MAX_U128
        "Parameter value '#{value}' is out of range."
      else
        str = value.to_s(16)
        arr = str.scan(/[0-9a-f]{4}/).map { |x| x.to_i(16) }
        packed = arr.pack("n*").unpack("C*").reverse()
      end
    end
  end

  module CLU256BytesParser
    def from_bytes(byte_array)
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
    end

    def to_bytes(value)
      if value < 0 || value > MAX_U256
        "Parameter value '#{value}' is out of range."
      else
        str = value.to_s(16)
        arr = str.scan(/[0-9a-f]{4}/).map { |x| x.to_i(16) }
        packed = arr.pack("n*").unpack("C*").reverse()
      end
    end
  end
  
  module CLU512BytesParser
    def from_bytes(byte_array)
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
    end

    def to_bytes(value)
      if value < 0 || value > MAX_U512
        "Parameter value '#{value}' is out of range."
      else
        str = value.to_s(16)
        arr = str.scan(/[0-9a-f]{4}/).map { |x| x.to_i(16) }
        packed = arr.pack("n*").unpack("C*").reverse()
      end
    end
  end

  module CLUnitBytesParser
    def from_bytes(byte_array)
      if byte_array.empty?
        [].pack("")
      else
        "byte_array should be empty!"
      end
    end
    
    def to_bytes
      "".bytes
    end


  end
end

