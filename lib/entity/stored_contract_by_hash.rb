module Casper
  module Entity
    class StoredContractByHash < DeployExecutableItemInternal
      
      # @param [String] name
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
    end
  end
end