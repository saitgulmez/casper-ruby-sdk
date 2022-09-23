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
        @header = Casper::Entity::BlockHeader.new(header)
        @body = Casper::Entity::BlockBody.new(body)
        @proofs = []
        proofs.each { |proof| @proofs << Casper::Entity::BlockProof.new(proof) }
      end

      # @return [String] block hash
      def get_hash
        @hash
      end

      # @return [BlockHeader] block header
      def get_header
        @header
      end

      # @return [BlockBody] block body
      def get_body
        @body
      end

      # @return [Array<BlockProof>] list of proofs for this block
      def get_proofs
        @proofs
      end
    end
  end
end