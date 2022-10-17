module Casper
  module Entity
    # Named arguments passed as input in a Deploy item. 
    class DeployNamedArgument

      def initialize(name, clvalue)
        @name = name
        @clvalue = clvalue
      end

      def get_name
        @name
      end

      def get_value
        @clvalue
      end

      # @return [Array] byte array containing two's complement
      #  
      def to_byte_array(num)
        result = []
        begin
          result << (num & 0xff)
          num >>= 8
        end until (num == 0 || num == -1) && (result.last[7] == num[7])
        # result.reverse
        result
      end



      def to_hash
        serializer = CLValueSerializer.new
        value = @clvalue.get_value
        type = @clvalue.get_cl_type
        if @name == "amount"
          bytes = Utils::ByteUtils.byte_array_to_hex(to_byte_array(value))[0...-2]
          num_of_bytes = bytes.length/2
          [num_of_bytes].pack("C*").unpack1("H*") + bytes 
          [
            @name,
            {
              "bytes": [num_of_bytes].pack("C*").unpack1("H*") + bytes,
              "parsed": @clvalue.get_value,
              "cl_type": @clvalue.get_cl_type
            }
          ]
          elsif @name == "target" && type == "PublicKey"
            [
              @name,
              {
                "bytes": @clvalue.to_hex,
                "parsed": @clvalue.to_hex,
                "cl_type": @clvalue.get_cl_type
              }
            ]
          elsif @name == "id"
            data = @clvalue.get_value
            inner_type = data.get_cl_type
            inner_value = data.get_value
            parsed = inner_value
            bytes = "01" + serializer.only_value(data)
            [
              @name,
              {
                "bytes": bytes,
                "parsed": parsed,
                "cl_type": {
                  "#{type}": inner_type
                }
              }
            ]
          end

      end
    end
  end
end