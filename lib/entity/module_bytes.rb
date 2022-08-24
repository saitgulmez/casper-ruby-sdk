module Casper
  module Entity
    class ModuleBytes < DeployExecutableItemInternal

      # @param [String] module_bytes
      # @param [Array<Array<DeployNamedArgument>>] args
      def initialize(module_bytes, args)
        @tag = 0
        @module_bytes = module_bytes
        @args = args
      end

      def get_tag
        @tag
      end
      
      def get_module_bytes
        @module_bytes
      end

      def get_args
        @args
      end
    end
  end
end 