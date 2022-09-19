module Casper
  module Entity
    # An Account is a structure that represents a user on a Casper Network.
    class Account
     
      # @param [CLAccountHash] account_hash
      # @param [Array] named_keys
      # @param [CLUref] main_purse  The account's main purse URef
      # @param [Array] associated_keys
      # @param [Array<ActionThresHolds>] action_thresholds
      def initialize(account_hash, named_keys, main_purse, associated_keys, action_thresholds)
        @account_hash = account_hash
        @named_keys = named_keys
        @main_purse = main_purse
        @associated_keys = associated_keys
        @action_thresholds = action_thresholds
      end

      # @return [CLAccountHash] 
      def get_account_hash
        @account_hash
      end

      # @return [Array]
      def get_named_keys
        @named_keys
      end

      # @return [CLUref]
      def get_main_purse
        @main_purse
      end

      # @return [Array<AssociatedKey>]
      def get_associated_keys
        @associated_keys
      end

      # @return [ActionThresHolds]
      def get_action_thresholds
        @action_thresholds
      end
    end
  end
end