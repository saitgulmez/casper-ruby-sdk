module Utils
  module Base16
    module_function

    # @param [Array<Integer>] byte_array
    # @return [String] encoded
    def encode16(byte_array)
      encoded = byte_array.pack("C*").unpack("H*").first
    end

    # @param [String] str
    # @return [Array<Integer>] decoded
    def decode16(str)
      decoded = [str].pack('H*').unpack("C*")
    end
  end

end