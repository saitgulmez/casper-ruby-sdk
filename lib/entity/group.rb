module Casper
  module Entity

    class Group

      # @param [String] group
      # @param [Array<CLURef>] keys
      def initialize(group, keys)
        @group = group
        @keys = keys
      end

      # @return [String] group
      def get_group
        @group
      end

      # @return [Array<CLURef>] keys
      def get_keys
        @keys
      end

    end
  end
end
