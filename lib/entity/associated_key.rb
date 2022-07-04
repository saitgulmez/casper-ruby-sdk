module Casper
  module Entity

    class AssociatedKey

      # @param [CLAccountHash] account_hash
      # @param [Integer] weight
      def initialize(account_hash, weight)
        @account_hash = account_hash
        @weight = weight
      end

      # @return [CLAccountHash] account hash of associated key
      def get_account_hash
        @account_hash
      end

      # @return [Integer] weight of an associated key.
      def get_weight
        @weight
      end
    end
  end
end