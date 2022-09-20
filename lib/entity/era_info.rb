module Casper
  module Entity

    # Auction metadata, intended to be recorded each era.
    class EraInfo

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