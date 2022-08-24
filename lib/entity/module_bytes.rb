module Casper
  module Entity
    class ModuleBytes < DeployExecutableItemInternal

      def initialize(module_bytes)
        @tag = 0
        @module_bytes = module_bytes
      end

      def get_module_bytes
        @module_bytes
      end

      def get_tag
        @tag
      end
    end
  end
end 