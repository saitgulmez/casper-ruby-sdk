module Casper
  module Entity
    class StoredVersionedContractByName < DeployExecutableItemInternal
   
      # @param [String] name
      # @param [Integer] version
      # @param [String] entry_point
      # @param [Array<Array<DeployNamedArgument>>] args
      def initialize(name, version, entry_point, args)
        @tag = 4
        @name = name
        @version = version
        @entry_point = entry_point
        @args = args
      end

      def get_tag
        @tag
      end

      def get_name
        @name
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