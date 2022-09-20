module Casper
  module Entity
    # A validator's weight.
    class ValidatorWeight

      # @param [String] public_key
      # @param [String] weight
      def initialize(public_key, weight)
        @public_key = public_key
        @weight = weight
      end

      # @return [String] public_key
      def get_public_key
        @public_key
      end

      # @return [String] weight
      def get_weight
        @weight
      end
    end
  end
end
