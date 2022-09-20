module Casper
  module Entity
    # Validator and weights for an Era.
    class EraValidator

      # @param [Integer] era_id
      # @param [Array<ValidatorWeight>] validator_weights
      def initialize(era_id, validator_weights)
        @era_id = era_id
        @validator_weights = validator_weights
      end

      # @return [Integer] era_id
      def get_era_id
        @era_id
      end

      # @return [Array<ValidatorWeight>] validator_weights
      def get_validator_weights
        @validator_weights
      end
    end
  end
end
