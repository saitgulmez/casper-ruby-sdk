module Casper
  module Entity
    class BidInfo  

      # @param [String] bonding_purse
      # @param [String] staked_amount
      # @param [Integer] delegation_rate
      # @param [VestingSchedule] vesting_schedule
      # @param [Hash<Delegator>] delegators
      # @param [Boolean] inactive
      def initialize(bonding_purse, staked_amount, delegation_rate, vesting_schedule, delegators, inactive)
        @bonding_purse = bonding_purse
        @staked_amount = staked_amount
        @delegation_rate = delegation_rate
        @vesting_schedule = vesting_schedule
        @delegators = delegators
        @inactive = inactive
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
    
      # @return [VestingSchedule] vesting_schedule
      def get_vesting_schedule
        @vesting_schedule
      end

      # @return [Delegator] delegators
      def get_delegators
        @delegators
      end

      # @return [true, false] inactive
      def get_inactive
        @inactive
      end
    end
  end
end
