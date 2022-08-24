module Casper
  module Entity
    class StoredContractByName < DeployExecutableItemInternal
   
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
      
    end
  end
end