require_relative './deploy_executable_item_internal.rb'

module Casper
  module Entity
    # Stored versioned contract referenced by its ContractPackageHash, 
    #  entry point and an instance of RuntimeArgs.
    class StoredVersionedContractByHash < DeployExecutableItemInternal
   
      # @param [String] hash
      # @param [Integer] version
      # @param [String] entry_point
      # @param [Array<Array<DeployNamedArgument>>] args
      def initialize(hash, version, entry_point, args)
        @tag = 3
        @hash = hash
        @version = version
        @entry_point = entry_point
        @args = args
      end

      def get_tag
        @tag
      end

      def get_hash
        @hash
      end

      def get_version
        @version
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
        if @version == nil
          bytes += Utils::ByteUtils.to_u8(0)
        else
          bytes += Utils::ByteUtils.to_u8(1)
        end
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