module Casper
  module Entity
    class Bid

      # @param [String] bonding_purse
      # @param [String] staked_amount
      # @param [Integer] delegation_rate
      # @param [String] reward
      # @param [Delegator] delegators
      def initialize(bonding_purse, staked_amount, delegation_rate, reward, delegators)
        @bonding_purse = bonding_purse
        @staked_amount = staked_amount
        @delegation_rate = delegation_rate
        @reward = reward
        @delegators = delegators
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

      # @return [String] reward
      def get_reward
        @reward
      end

      # @return [Delegator] delegators
      def get_delegators
        @delegators
      end
    end
  end
end