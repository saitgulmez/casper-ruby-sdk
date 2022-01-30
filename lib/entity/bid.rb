module Casper
  module Entity
    class Bid

      # @param [String] public_key
      # @param [BidInfo] bid_info
      def initialize(public_key, bid_info)
        @public_key = public_key
        @BidInfo = bid_info

      end

      # @return [String] public_key
      def get_public_key
        @public_key
      end

      # @return [BidInfo] bid_info
      def get_bid_info
        @bid_info
      end
    end
  end
end