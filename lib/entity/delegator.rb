module Casper
  module Entity
    # A delegator associated with the given validator.
    class Delegator
      
      # @param [String] public_key
      # @param [String] staked_amount
      # @param [String] bonding_purse
      # @param [String] delegatee
      def initialize(public_key, staked_amount, bonding_purse, delegatee)
        @public_key = public_key
        @staked_amount = staked_amount
        @bonding_purse = bonding_purse
        @delegatee = delegatee
      end

      # @return [String] public_key
      def get_public_key
        @public_key
      end

      # @return [String] staked_amount
      def get_staked_amount
        @staked_amount  
      end

      # @return [String] bonding_purse
      def get_bonding_purse
        @bonding_purse  
      end

      # @return [String] delegatee
      def get_delegatee 
        @delegatee  
      end
    end
  end
end
