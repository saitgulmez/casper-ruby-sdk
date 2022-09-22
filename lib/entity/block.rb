module Casper
  module Entity
    # Block 
    class Block

      # @param [String] hash
      # @param [Hash] header
      # @param [Hash] body
      # @param [Array<Hash>] proofs
      def initialize(hash, header = {}, body = {}, proofs = [])
        @hash = hash
        @header = header
        @body = body
        @proofs = proofs
      end

      # @return [String] hash
      def get_hash
        @hash
      end

      # @return [Hash] header
      def get_header
        @header
      end

      # @return [Hash] body
      def get_body
        @body
      end

      # @return [Array<Hash>] proofs
      def get_proofs
        @proofs
      end
    end
  end
end