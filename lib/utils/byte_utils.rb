module Utils
  module ByteUtils
    extend self

    # @param [String] string
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
   
    # @param [Array] byte_array
    # @return [String]
    def byte_array_to_hex(byte_array)
      # byte_array.pack("C*").unpack1("H*")
      byte_array.pack("C*").unpack("H*").first
    end

    # @param [String] string
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

    def to_u32(n)
      [n].pack("L<*").unpack("H*").first
      # [n].pack("L<*").unpack1("H*")
    end
    # @param [Integer] n
    # @return [String]
    def to_u64(n)
      [n].pack("Q<*").unpack("H*").first
    end

    # @param [String] hex_str
    # @param [String] 
    def hex_from_little_endian_to_big_endian(hex_str)
      # [hex_str].pack("H*").unpack('N*').pack('V*').unpack1('H*')
      [hex_str].pack("H*").unpack('N*').pack('V*').unpack('H*').first
    end
  end
end