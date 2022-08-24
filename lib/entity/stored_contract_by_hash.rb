module Casper
  module Entity
    class StoredContractByHash < DeployExecutableItemInternal
      
      def initialize(hash, entry_point)
        @tag = 1
        @hash = hash
        @entry_point = entry_point
      end

      def get_hash
        @hash
      end

      def get_entry_point
        @entry_point
      end

      def get_tag
        @tag
      end
    end
  end
end