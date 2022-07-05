module Casper
  module Entity

    # Information about seigniorage allocation.
    class SeigniorageAllocation

      # @param [Array] seigniorage_allocations rewards list allocated to validators and delegators
      def initialize(seigniorage_allocations)
        @seigniorage_allocations = seigniorage_allocations
      end

      # @return [Array]
      def get_seigniorage_allocations
        @seigniorage_allocations
      end
    end 
  end
end