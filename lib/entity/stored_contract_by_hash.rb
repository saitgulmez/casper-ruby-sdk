require_relative './deploy_executable_item_internal.rb'

module Casper
  module Entity
    # Stored contract referenced by its ContractHash, entry point and an instance of RuntimeArgs.
    class StoredContractByHash < DeployExecutableItemInternal
      
      # @param [String] hash
      # @param [String] entry_point
      # @param [Array<Array<DeployNamedArgument>>] args
      def initialize(hash, entry_point, args)
        @tag = 1
        @hash = hash
        @entry_point = entry_point
        @args = args
      end

      def get_tag
        @tag
      end

      def get_hash
        @hash
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
        bytes += @hash
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