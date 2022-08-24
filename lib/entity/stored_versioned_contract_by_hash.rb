module Casper
  module Entity
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

    end
  end
end