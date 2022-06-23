module Utils
  module ByteUtils
    extend self

    # @param [String] string
    # @return [String] hex_string
    def string_to_hex(str)
      str.unpack1("H*")
    end

    # @param [String] hex_string
    # @return [String] string
    def hex_to_string(hex_string)
      [hex_string].pack("H*")
    end

    # @param [String] hex_string
    # @return [Array] byte_array
    def hex_to_byte_array(hex_string)
      [hex_string].pack("H*").unpack("C*")
    end
   
    # @param [Array] byte_array
    # @return [String] string
    def byte_array_to_hex(byte_array)
      byte_array.pack("C*").unpack1("H*")
    end

    # @param [String] string
    # @return [Array] byte_array
    def string_to_byte_array(str)
      str.unpack("C*")
    end

    # @param [Array] byte_array
    # @return [String] string
    def byte_array_to_string(byte_array)
      byte_array.pack("C*")
    end 

    # @param [String] string
    # @param [Array<int>] bytes
    def string_to_bytes_u32(str)

    end
  end
end