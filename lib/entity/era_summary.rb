module Casper
  module Entity
    # The summary of an era.
    class EraSummary

      # @param [Hash] era_summary
      # @option era_summary [String] :block_hash
      # @option era_summary [Integer] :era_id
      # @option era_summary [Hash] :stored_value
      # @option era_summary [String] :state_root_hash
      # @option era_summary [String] :merkle_proof
      def initialize(era_summary = {})
        @block_hash = era_summary[:block_hash]
        @era_id = era_summary[:era_id]
        @stored_value = Casper::Entity::StoredValue.new(era_summary[:stored_value])
        @state_root_hash = era_summary[:state_root_hash]
        @merkle_proof = era_summary[:merkle_proof]
      end

      # @return [String] block_hash
      def get_block_hash
        @block_hash
      end

      # @return [Integer] era_id
      def get_era_id
        @era_id
      end

      # @return [Hash] StoredValue
      def get_stored_value
        @stored_value
      end

      # @return [String] state_root_hash
      def get_state_root_hash
        @state_root_hash
      end

      # @return [String] merkle_proof
      def get_merkle_proof
        @merkle_proof
      end
    end
  end
end