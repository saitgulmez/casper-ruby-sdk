require_relative './deploy_executable_item_internal.rb'

module Casper
  module Entity
    class StoredContractByName < DeployExecutableItemInternal
   
      # @param [String] name
      # @param [String] entry_point
      # @param [Array<Array<DeployNamedArgument>>] args
      def initialize(name, entry_point, args)
        @tag = 2
        @name = name
        @entry_point = entry_point
        @args = args
      end

      def get_tag
        @tag
      end

      def get_name
        @name
      end

      def get_entry_point
        @entry_point
      end

      def get_args
        @args
      end

    
      def to_bytes
        serializer = DeployNamedArgSerializer.new
        num_of_args = @args.length
        bytes = Utils::ByteUtils.to_u8(@tag) 
        bytes += CLValueBytesParsers::CLStringBytesParser.to_bytes(@name)
        bytes += CLValueBytesParsers::CLStringBytesParser.to_bytes(@entry_point)
        bytes += Utils::ByteUtils.to_u32(num_of_args)
        @args.each do |arg|
          arg.each do |item|
            bytes += serializer.to_bytes(item)
          end
        end
        Utils::ByteUtils.hex_to_byte_array(bytes)
      end
    end
  end
end