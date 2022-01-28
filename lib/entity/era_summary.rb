module Casper
  module Entity
    class EraSummary

      # @param [String] block_hash
      # @param [Integer] era_id_
      # @param [StoredValue] stored_value_
      # @param [String] state_root_hash_
      # @param [String] merkle_proof_
      def initialize(block_hash_, era_id_, stored_value_, state_root_hash_, merkle_proof_)
        @block_hash = block_hash_
        @era_id = era_id_
        @stored_value = stored_value_
        @state_root_hash = state_root_hash_
        @merkle_proof = merkle_proof_
      end

      # @return [String] block_hash
      def get_block_hash
        @block_hash
      end

      # @return [Integer] era_id
      def get_era_id
        @era_id
      end

      # @return [StoredValue] StoredValue
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