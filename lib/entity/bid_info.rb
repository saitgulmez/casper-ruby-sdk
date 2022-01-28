module Casper
  module Entity
    class BidInfo  

      # @param [String] bonding_purse
      # @param [String] staked_amount
      # @param [Integer] delegation_rate
      # @param [String] funds_locked
      def initialize(bonding_purse, staked_amount, delegation_rate, funds_locked)
        @bonding_purse = bonding_purse
        @staked_amount = staked_amount
        @delegation_rate = delegation_rate
        @funds_locked = funds_locked
      end

      # @return [String] bonding_purse
      def get_bonding_purse
        @bonding_purse
      end
    
      # @return [String] staked_amount
      def get_staked_amount
        @staked_amount
      end
    
      # @return [Integer] delegation_rate
      def get_delegation_rate
        @delegation_rate
      end
    
      # @return [String] funds_locked
      def get_funds_locked
        @funds_locked
      end
    end
  end
end
