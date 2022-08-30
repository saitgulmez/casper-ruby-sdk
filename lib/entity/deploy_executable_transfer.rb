=begin
"Transfer": {
  "args": [
    [
      "amount",
      {
        "cl_type": "I32",
        "bytes": "e8030000",
        "parsed": 1000
      }
    ]
  ]
}

=end     
module Casper
  module Entity
    class DeployExecutableTransfer < DeployExecutableItemInternal
   
      # @param [Array<Array<DeployNamedArgument>>] args
      def initialize(args)
        @tag = 5
        @args = args
      end

      def get_tag
        @tag
      end

      def get_args
        @args 
      end

      def to_bytes
        serializer = DeployNamedArgSerializer.new
        num_of_args = @args.length
        bytes = Utils::ByteUtils.to_u8(@tag) + Utils::ByteUtils.to_u32(num_of_args)

        @args.each do |arg|
          arg.each do |item|
            bytes += serializer.to_bytes(item)
          end
        end
        bytes
      end
    end
  end
end