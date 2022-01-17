
module Casper
  module Entity
    class AuctionState
      # @param [String] state_root_hash
      # @param [Integer] block_height
      # @param [Array] era_validators
      # @param [Array]  bids
      def initialize(state_root_hash, block_height, era_validators, bids)
        @state_root_hash = state_root_hash
        @block_height = block_height
        @era_validators = era_validators
        @bids = bids
      end

      # @return [String] returns state root hash as a String
      def get_state_root_hash
        @state_root_hash
      end

      # @return [Integer] returns block height as an Integer 
      def get_block_height
        @block_height
      end

      # @return [Array<Hash>] returns array of hashes
      def get_era_validators
        @era_validators
      end

      # @return [Array<Hash>] returns array of hashes
      def get_bids
        @bids
      end
    end
  end
end
