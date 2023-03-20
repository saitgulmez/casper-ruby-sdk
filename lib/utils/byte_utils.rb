module Utils
  module ByteUtils
    extend self

    # @param [String] str
    # @return [String] 
    def string_to_hex(str)
      # str.unpack1("H*")
      str.unpack("H*").first
    end

    # @param [String] hex_str
    # @return [String]
    def hex_to_string(hex_str)
      [hex_str].pack("H*")
    end

    # @param [String] hex_str
    # @return [Array]
    def hex_to_byte_array(hex_str)
      [hex_str].pack("H*").unpack("C*")
    end

    # Convert a string of 0-F into a byte array 
    # hex = "0a0b"=> [10, 11]
    # hex = "0a0b0"=> [10, 11]
    # hex = "0a0b0c"=> [10, 11, 13]
    def convert_hex_to_byte_array(hex)
      hex.scan(/../).map(&:hex)
    end
   
    # @param [Array] byte_array
    # @return [String]
    def byte_array_to_hex(byte_array)
      # byte_array.pack("C*").unpack1("H*")
      byte_array.pack("C*").unpack("H*").first
    end
   
    def byte_array_to_hex_64(byte_array)
      # byte_array.pack("C*").unpack1("H*")
      byte_array.pack("C*").unpack("H*").first
    end

    # @param [String] str
    # @return [Array]
    def string_to_byte_array(str)
      str.unpack("C*")
    end

    # @param [Array] byte_array
    # @return [String]
    def byte_array_to_string(byte_array)
      byte_array.pack("C*")
    end 

    # @param [Integer] n
    # @return [String]
    def integer_to_hex(n)
      [n].pack("l<*").unpack("H*").first
    end

    # @param [String] hex_str
    # @return [Integer] 
    def hex_to_integer(hex_str)
      [hex_str].pack("H*").unpack("l").first
    end

    def to_i32(n)
      # [value].pack("l<*").unpack("C*")
      [n].pack("l<*").unpack("H*").first
      # [n].pack("l<*").unpack1("H*")
    end
    
    def to_i64(n)
      # [value].pack("l<*").unpack("C*")
      [n].pack("q<*").unpack("H*").first
      # [n].pack("l<*").unpack1("H*")
    end

    def to_u8(n)
      [n].pack("C").unpack1("H*")
    end
    def to_u32(n)
      [n].pack("L<*").unpack("H*").first
      # [n].pack("L<*").unpack1("H*")
    end
    # @param [Integer] n
    # @return [String]
    def to_u64(n)
      # bytes = Utils::ByteUtils.byte_array_to_hex(to_byte_array(n)) + "0000"
      # puts "bytes: #{bytes}"
      # puts "bytes_conversion: #{[bytes].pack("H*").unpack("C*")}"
      [n].pack("Q<*").unpack("H*").first
    end

    # @param [Integer] n
    # @return [String]
    def to_u512(n)
      [n].pack("Q<*").unpack("H*").first
    end

    # @param [String] hex_str
    # @return [String] 
    def hex_from_little_endian_to_big_endian(hex_str)
      # [hex_str].pack("H*").unpack('N*').pack('V*').unpack1('H*')
      [hex_str].pack("H*").unpack('N*').pack('V*').unpack('H*').first
    end

    def hex_to_i32_value(hex_str)
      [hex_str].pack("H*").unpack("l*").first
    end

    def hex_to_i64_value(hex_str)
      [hex_str].pack("H*").unpack("q*").first
    end

    def hex_to_u8_value(hex_str)
      [hex_str].pack("H*").unpack("C*").first
    end

    def hex_to_u32_value(hex_str)
      [hex_str].pack("H*").unpack("L*").first
    end

    def hex_to_u64_value(hex_str)
      [hex_str].pack("H*").unpack("Q*").first
    end
    def hex_to_u512_value(hex_str)
      [hex_str].pack("H*").unpack("Q*").first
    end

    # @return byte array containing two's complement representation of Bignum/Fixnum
    def to_byte_array(num)
      result = []
      begin
        result << (num & 0xff)
        num >>= 8
      end until (num == 0 || num == -1) && (result.last[7] == num[7])
      # result.reverse
      result
    end
  end
end