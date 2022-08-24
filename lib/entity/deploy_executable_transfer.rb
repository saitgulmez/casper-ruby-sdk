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

    end
  end
end